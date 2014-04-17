//
//  XYZSponsoreeInfo.m
//  iOS App
//
//  Created by Sujin Lee on 4/16/14.
//
//

#import "XYZSponsoreeInfo.h"
#import "XYZSponsoreeCell.h"
#import "XYZAppDelegate.h"

@interface XYZSponsoreeInfo ()

@end

@implementation XYZSponsoreeInfo {
    NSMutableArray *userNames;
    NSMutableArray *firstNames;
    NSMutableArray *dates;
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
    firstNames = [[NSMutableArray alloc] init];
    dates = [[NSMutableArray alloc] init];
    riskCounts = [[NSMutableArray alloc] init];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [userNames count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"sponsoreeCell";
    XYZSponsoreeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[XYZSponsoreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
    cell.userLabel.text = @"@";
    cell.userLabel.text = [cell.userLabel.text stringByAppendingString:[[userNames objectAtIndex:indexPath.row] lowercaseString]];
    [cell.userLabel sizeToFit];
    cell.firstLabel.text = [[firstNames objectAtIndex:indexPath.row] capitalizedString];
    [cell.firstLabel sizeToFit];
    
    NSString *str = [dates objectAtIndex:indexPath.row];
    //NSLog(@"original string %@", str);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'.000Z'"];
    NSDate *dte = [dateFormat dateFromString:str];
    //NSLog(@"convert to date %@", str);
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateStyle:NSDateFormatterMediumStyle];
    [dateFormat2 setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [dateFormat2 stringFromDate:dte];
    //NSLog(@"DateString: %@", dateString);
    
    cell.dateLabel.text = dateString;
    [cell.dateLabel sizeToFit];
    
    cell.riskCount.text = [NSString stringWithFormat:@"%@", [riskCounts objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)viewWillAppear:(BOOL)animated {
    [self refreshInfo];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [riskCounts removeAllObjects];
    [userNames removeAllObjects];
    [firstNames removeAllObjects];
    [dates removeAllObjects];
}

-(void)refreshInfo {
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
                    [firstNames addObject:dict[@"firstname"]];
                    [riskCounts addObject:dict[@"riskcount"]];
                    [dates addObject:dict[@"dateposted"]];
                }
            }
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not get sponsoree info" message:@"Something went wrong. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

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
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
