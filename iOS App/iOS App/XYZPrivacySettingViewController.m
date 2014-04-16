//
//  XYZPrivacySettingViewController.m
//  iOS App
//
//  Created by Sujin Lee on 3/19/14.
//
//

#import "XYZPrivacySettingViewController.h"
#import "XYZAppDelegate.h"

@interface XYZPrivacySettingViewController ()

@end

@implementation XYZPrivacySettingViewController

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
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    [super viewDidLoad];
    [self.showPhoneNumber setOn:appDelegate.userSettings.showPhone];
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

- (IBAction)displayPhone:(id)sender {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    if (appDelegate.userSettings.showPhone) {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/member/edit"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"oldusername",
                                     appDelegate.userSettings.username, @"username",
                                     appDelegate.userSettings.firstname, @"firstname",
                                     appDelegate.userSettings.password, @"password",
                                     appDelegate.userSettings.setSponsor, @"sponsorid",
                                     appDelegate.userSettings.email, @"email",
                                     appDelegate.userSettings.phoneNumber, @"phonenumber",
                                     @"0", @"displayphonenumber",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"contacts: %@", post_string);
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            appDelegate.userSettings.showPhone = FALSE;
            [self.showPhoneNumber setOn:NO];
        }
        else {
            [self.showPhoneNumber setOn:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot unblock phone number" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        
    }
    else {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/member/edit"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"oldusername",
                                     appDelegate.userSettings.username, @"username",
                                     appDelegate.userSettings.firstname, @"firstname",
                                     appDelegate.userSettings.password, @"password",
                                     appDelegate.userSettings.setSponsor, @"sponsorid",
                                     appDelegate.userSettings.email, @"email",
                                     appDelegate.userSettings.phoneNumber, @"phonenumber",
                                     @"1", @"displayphonenumber",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"contacts: %@", post_string);
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            appDelegate.userSettings.showPhone = TRUE;
            [self.showPhoneNumber setOn:YES];
        }
        else {
            [self.showPhoneNumber setOn:NO];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot block number" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

/*
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
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
