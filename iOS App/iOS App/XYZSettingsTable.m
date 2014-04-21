//
//  XYZSettingsTable.m
//  iOS App
//
//  Created by John Nowotny on 2/13/14.
//
//

#import "XYZSettingsTable.h"
#import "XYZAppDelegate.h"


@interface XYZSettingsTable () 

@end

@implementation XYZSettingsTable {
    NSMutableArray *userNames;
    NSMutableArray *riskCounts;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    userNames = [[NSMutableArray alloc] init];
    riskCounts = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated {
    [userNames removeAllObjects];
    [riskCounts removeAllObjects];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    self.tabBarController.navigationItem.rightBarButtonItem.title = @"";
    self.tabBarController.navigationItem.rightBarButtonItem.enabled = NO;
    
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"https://paulgreco.net/member/getlog"]];
    
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 appDelegate.userSettings.username, @"rusername",
                                 appDelegate.userSettings.password, @"rpassword",
                                 appDelegate.userSettings.username, @"sponsorusername",
                                 nil];
    NSError *error;
    NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    NSData *authData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *authReturn = [[NSString alloc] initWithData:authData encoding:NSUTF8StringEncoding];
    NSLog(@"sponsoree info is %@", authReturn);
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    }
    
     if (!([authReturn rangeOfString:@"true"].location == NSNotFound)) {
         NSError *error2;
         NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:authData options:NSJSONReadingMutableContainers error:&error2];
         if (error2) {
             return;
             NSLog(@"Second error: %@", [error2 localizedDescription]);
         }
         for(NSDictionary *dict in array){
             if (dict[@"valid"]);
             else {
                 if (dict[@"username"]) {
                     [userNames addObject:dict[@"username"]];
                     [riskCounts addObject:dict[@"riskcount"]];
                 }
             }
         }
     }
    
    self.navigationItem.hidesBackButton = YES;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 && indexPath.section == 0)
    {
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Log Out" message:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
    
        // Display Alert Message
        [messageAlert show];
    }
    if (indexPath.row == 0 && indexPath.section == 1) {
        if ([userNames count] > 0)
            [self performSegueWithIdentifier:@"sponsoreeInfo" sender:nil];
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"No sponsorees" message:@"You are not the sponsor of any member!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;

    
    if([title isEqualToString:@"Yes"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [appDelegate.userSettings resetAllObjects];
        [appDelegate.locationManager stopMonitoringSignificantLocationChanges];
    }
}


#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}
*/
/*
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 6;
}
*/
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [settings objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}
*/
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
