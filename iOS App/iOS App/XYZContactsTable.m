//
//  XYZContactsTable.m
//  iOS App
//
//  Created by John Nowotny on 2/13/14.
//
//

#import "XYZContactsTable.h"
#import "XYZContactCell.h"
#import "XYZContactView.h"
#import "XYZUserSettings.h"
#import "XYZAppDelegate.h"

@interface XYZContactsTable ()

@end

@implementation XYZContactsTable{
    NSMutableArray *firstNames;
    NSMutableArray *userNames;
    NSMutableArray *phoneNumbers;
    NSMutableArray *blockedUsers;
    NSMutableArray *displayphonenumber;
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    firstNames = [[NSMutableArray alloc] init];
    userNames = [[NSMutableArray alloc] init];
    phoneNumbers = [[NSMutableArray alloc] init];
    blockedUsers = [[NSMutableArray alloc] init];
    displayphonenumber = [[NSMutableArray alloc] init];

}

- (void)viewDidUnload
{
    //[self setSearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    [phoneNumbers removeAllObjects];
    [displayphonenumber removeAllObjects];
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
    NSLog(@"contactss: %@", post_string);
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
                    [userNames addObject:dict[@"username"]];
                    [firstNames addObject:dict[@"firstname"]];
                    [phoneNumbers addObject:dict[@"phonenumber"]];
                    [displayphonenumber addObject:dict[@"displayphonenumber"]];
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
    //if(self.isFiltered) {
    //    return [searchResults count];
    //}else{
        return [userNames count];
    //}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"contactCell";
    XYZContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[XYZContactCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.firstNameLabel.text = [firstNames objectAtIndex:indexPath.row];
    [cell.firstNameLabel sizeToFit];
    cell.userNameLabel.text = @"@";
    cell.userNameLabel.text = [cell.userNameLabel.text stringByAppendingString:[[userNames objectAtIndex:indexPath.row] lowercaseString]];
    
    //cell.userNameLabel.text = [userNames objectAtIndex:indexPath.row];
    [cell.userNameLabel sizeToFit];

    // Configure the cell...
    
    return cell;
}

/*
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self showDetailsForIndexPath:indexPath];
    
 [tableView deselectRowAtIndexPath:indexPath animated:NO];
    XYZContactView *contact = [self.storyboard instantiateViewControllerWithIdentifier:@"contactView"];
    contact.firstNameLabel.text = firstNames[indexPath.row];
    contact.usernameLabel.text = userNames[indexPath.row];
    [contact.phoneButton setTitle:phoneNumbers[indexPath.row] forState:UIControlStateNormal];
    [self performSegueWithIdentifier:@"contactPush" sender:nil];
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
#pragma mark - Table view delegate

-(void)searchBar:(UISearchBar*)searchBar textDidChange:(NSString *)text{
    if(text.length == 0){
        _isFiltered = FALSE;
    }else{
        _isFiltered = TRUE;
        for(XYZUserSettings* user in users){
            NSRange nameRange = [user.firstname rangeOfString:text options:NSCaseInsensitiveSearch];
            NSRange usernameRange = [user.username rangeOfString:text options:NSCaseInsensitiveSearch];
            if(nameRange.location != NSNotFound || usernameRange.location != NSNotFound){
                [searchResults addObject:user];
            }
        }
    }
    [self.tableView reloadData];
}*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"contactPush"]) {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NSString *first = firstNames[indexPath.row];
        NSString *user = userNames[indexPath.row];
        NSString *phone = phoneNumbers[indexPath.row];
        NSString *displayphone = displayphonenumber[indexPath.row];
        [[segue destinationViewController] setFirstName:first];
        [[segue destinationViewController] setUserName:user];
        [[segue destinationViewController] setPhoneNumber:phone];
        [[segue destinationViewController] setDisplayPhone:displayphone];
        
        if ([blockedUsers containsObject:userNames[indexPath.row]])
            [[segue destinationViewController] setIsBlocked:YES];
        else
            [[segue destinationViewController] setIsBlocked:NO];
        
        if ([appDelegate.userSettings.setSponsor isEqualToString:userNames[indexPath.row]])
            [[segue destinationViewController] setIsSponsor:YES];
        else
            [[segue destinationViewController] setIsSponsor:NO];
    }
}

@end
