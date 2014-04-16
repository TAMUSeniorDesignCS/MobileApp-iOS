//
//  XYZNewMessage.m
//  iOS App
//
//  Created by Sujin Lee on 4/10/14.
//
//

#import "XYZNewMessage.h"
#import "XYZAppDelegate.h"
#import "XYZNewMessageCell.h"
#import "XYZBubbleMessage.h"

@interface XYZNewMessage (){
    NSMutableArray *userNames;
    NSMutableArray *firstNames;
    NSMutableArray *blockedUsers;
}

@end

@implementation XYZNewMessage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    firstNames = [[NSMutableArray alloc] init];
    userNames = [[NSMutableArray alloc] init];
    blockedUsers = [[NSMutableArray alloc] init];
    
}

- (void)viewDidUnload
{
    //[self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [firstNames count];
}

- (NSInteger)numberOfSections:(UITableView *)tableView
{
    return 1;
}

- (void)viewWillAppear:(BOOL)animated {
    animated = NO;
    //[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    self.tabBarController.navigationItem.rightBarButtonItem.title = @"";
    self.tabBarController.navigationItem.rightBarButtonItem.enabled = NO;
    [self refreshContacts];
    [self getBlockedUsers];
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [userNames removeAllObjects];
    [firstNames removeAllObjects];
    [blockedUsers removeAllObjects];
}

- (void)refreshContacts {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/member/getinfo"]];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 appDelegate.userSettings.username, @"rusername",
                                 appDelegate.userSettings.password, @"rpassword",
                                 [NSString stringWithFormat:@"%d", appDelegate.userSettings.groupId], @"groupid",
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
        NSError *error2;
        NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error2];
        if (error2) {
            return;
            NSLog(@"Second error: %@", [error2 localizedDescription]);
        }
        for(NSDictionary *dict in array){
            if (dict[@"valid"]);
            else {
                if (!([dict[@"username"] isEqualToString:appDelegate.userSettings.username])) {
                    /*XYZUserSettings *user = [XYZUserSettings new];
                     user.username = dict[@"username"];
                     user.firstname = dict[@"firstname"];
                     user.phoneNumber = dict[@"phonenumber"];
                     [users addObject:user];*/
                    
                    [userNames addObject:dict[@"username"]];
                    [firstNames addObject:dict[@"firstname"]];
                }
            }
        }
    }
}

- (void)getBlockedUsers {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/userblock/getinfo"]];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 appDelegate.userSettings.username, @"rusername",
                                 appDelegate.userSettings.password, @"rpassword",
                                 appDelegate.userSettings.username, @"username",
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
        NSError *error2;
        NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error2];
        if (error2) {
            return;
            NSLog(@"Second error: %@", [error2 localizedDescription]);
        }
        for(NSDictionary *dict in array){
            if (dict[@"valid"]);
            else {
                [blockedUsers addObject:dict[@"blockeduser"]];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newMessageCell";
    XYZNewMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[XYZNewMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.firstLabel.text = [firstNames objectAtIndex:indexPath.row];
    [cell.firstLabel sizeToFit];
    cell.userLabel.text = @"@";
    cell.userLabel.text = [cell.userLabel.text stringByAppendingString:[[userNames objectAtIndex:indexPath.row] lowercaseString]];
    
    //cell.userNameLabel.text = [userNames objectAtIndex:indexPath.row];
    [cell.userLabel sizeToFit];
    
    // Configure the cell...
    
    return cell;
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"newMessagePush"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        XYZNewMessageCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
        NSString *chatBuddy = [cell.userLabel.text stringByReplacingOccurrencesOfString:@"@" withString:@""];
        NSMutableDictionary *messages = [[NSMutableDictionary alloc] init];
        [[segue destinationViewController] setChatData:messages];
        [[segue destinationViewController] setChatBuddyName:chatBuddy];
        [[segue destinationViewController] setIsNewMessage:TRUE];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

