//
//  XYZMessagesView.m
//  iOS App
//
//  Created by John Nowotny on 3/24/14.
//
//

#import "XYZMessagesView.h"
#import "XYZTabBarViewController.h"
#import "XYZAppDelegate.h"
#import "XYZMessageCell.h"
#import "XYZBubbleMessage.h"

@interface XYZMessagesView ()

@end

@implementation XYZMessagesView

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
    dates = [[NSMutableArray alloc] init];
    messages = [[NSMutableDictionary alloc] init];
    messageIDs = [[NSMutableArray alloc] init];
    
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

- (void) viewWillAppear:(BOOL)animated {
    animated = NO;
    self.tabBarController.navigationItem.rightBarButtonItem.title = @"New Message";
    self.tabBarController.navigationItem.rightBarButtonItem.enabled = YES;
    [self refreshMessages];
    [self.tableView reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [userNames removeAllObjects];
    [dates removeAllObjects];
    [messageIDs removeAllObjects];
}

-(void)refreshMessages{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/directmessage/refresh"]];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 appDelegate.userSettings.username, @"username",
                                 @"-", @"directmessageidlimit",
                                 nil];
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestData];
    NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Direct message: %@", post_string);
    if (error) {
        return;
        NSLog(@"First error: %@", [error localizedDescription]);
    }
    if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
        NSError *error2;
        NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error2];
        messages = [array mutableCopy];
        if (error2) {
            return;
            NSLog(@"Second error: %@", [error2 localizedDescription]);
        }
        for(NSDictionary *dict in array){
            if (dict[@"valid"]);
            else {
                if ([dict[@"username"] isEqualToString:appDelegate.userSettings.username]) {
                    if (!([userNames containsObject:dict[@"receiversusername"]]))
                        [userNames addObject:dict[@"receiversusername"]];
                }
                else {
                    if (!([userNames containsObject:dict[@"username"]]))
                           [userNames addObject:dict[@"username"]];
                }
                [dates addObject:dict[@"dateposted"]];
                [messageIDs addObject:dict[@"directmessageid"]];
            }
        }
    }
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
    static NSString *CellIdentifier = @"messageCell";
    XYZMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[XYZMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.username.text = @"@";
    cell.username.text = [cell.username.text stringByAppendingString:[[userNames objectAtIndex:indexPath.row] lowercaseString]];
    [cell.username sizeToFit];
    
    
    NSString *str = [dates objectAtIndex:indexPath.row];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'.000Z'"];
    NSDate *dte = [dateFormat dateFromString:str];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MM/dd/YYYY HH:mm"];
    NSString *dateString = [dateFormat2 stringFromDate:dte];
    cell.date.text = dateString;
    [cell.date sizeToFit];
    // Configure the cell...
    
    return cell;
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"chatPush"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        XYZMessageCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *chatBuddy = [cell.username.text stringByReplacingOccurrencesOfString:@"@" withString:@""];
        [[segue destinationViewController] setChatData:messages];
        [[segue destinationViewController] setChatBuddyName:chatBuddy];
    }
    
}


@end
