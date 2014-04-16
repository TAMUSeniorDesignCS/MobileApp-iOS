//
//  XYZSecondViewController.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import "XYZSecondViewController.h"
#import "XYZPostCell.h"
#import "XYZAppDelegate.h"

@interface XYZSecondViewController ()

@end

@implementation XYZSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.editing = YES;
    postIDs = [[NSMutableArray alloc] init];
    myPosts = [[NSMutableArray alloc] init];
    firstNames = [[NSMutableArray alloc] init];
    userNames = [[NSMutableArray alloc] init];
    dates = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)refreshPost
{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/post/refresh"]];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                [NSString stringWithFormat:@"%d", appDelegate.userSettings.groupId], @"groupid",
                                appDelegate.userSettings.username, @"rusername",
                                appDelegate.userSettings.username, @"username",
                                appDelegate.userSettings.password, @"rpassword",
                                @"-", @"postidlimit",
                                nil];
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:&error];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestData];
    NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    NSLog(@"post string is %@", post_string);
    if (error) {
        return;
        NSLog(@"First error: %@", [error localizedDescription]);
    }
    else{
        NSError *error2;
        // Parse JSON
        NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error2];
        if (error2) {
            return;
            NSLog(@"Second error: %@", [error2 localizedDescription]);
        }
        else{
            for(NSDictionary *dict in array){
                if (dict[@"valid"]) {
                    /*
                    if ([dict[@"valid"] isEqualToString:@"false"]) {
                        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot retrieve posts" message:@"Something went wrong." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                        [alertView show];
                        return;
                    }
                     */
                }
                else {
                    [postIDs addObject:dict[@"postid"]];
                    [myPosts addObject:dict[@"message"]];
                    [userNames addObject:dict[@"username"]];
                    [firstNames addObject:dict[@"firstname"]];
                    [dates addObject:dict[@"dateposted"]];
                }
                
            }
        }
    
        
        [self.tableView reloadData];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.hidesBackButton = YES;
    NSLog(@"refreshed!");
    [self refreshPost];
    self.tabBarController.navigationItem.rightBarButtonItem.title = @"New Post";
    self.tabBarController.navigationItem.rightBarButtonItem.enabled = YES;
    [self.tableView reloadData];
    
    CGRect frame = self.tableView.frame;
    frame.size.height -= 49;
    [self.tableView setFrame:frame];
    [super viewWillAppear:YES];

}

- (void)viewWillDisappear:(BOOL)animated
{
    [postIDs removeAllObjects];
    [myPosts removeAllObjects];
    [userNames removeAllObjects];
    [firstNames removeAllObjects];
    [dates removeAllObjects];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
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
    return [myPosts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    static NSString *CellIdentifier = @"postCell";
    XYZPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[XYZPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...

    cell.postTextBox.text = [myPosts objectAtIndex:indexPath.row];
    cell.userLabel.text = @"@";
    cell.userLabel.text = [cell.userLabel.text stringByAppendingString:[[userNames objectAtIndex:indexPath.row] lowercaseString]];
    [cell.userLabel sizeToFit];
    cell.editButton.tag = indexPath.row;
    if ([appDelegate.userSettings.username isEqualToString:[[userNames objectAtIndex:indexPath.row] lowercaseString]]) {
        [cell.editButton setEnabled:YES];
        [cell.editButton setTitle:@"Edit" forState:UIControlStateNormal];
    }
    else {
        [cell.editButton setEnabled:NO];
        [cell.editButton setTitle:@"" forState:UIControlStateNormal];
    }
    
    cell.firstLabel.text = [[firstNames objectAtIndex:indexPath.row] capitalizedString];
    [cell.firstLabel sizeToFit];
    
    NSString *str = [dates objectAtIndex:indexPath.row];
    //NSLog(@"original string %@", str);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'.000Z'"];
    NSDate *dte = [dateFormat dateFromString:str];
    //NSLog(@"convert to date %@", str);
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"MM/dd/YYYY HH:mm"];
    NSString *dateString = [dateFormat2 stringFromDate:dte];
    //NSLog(@"DateString: %@", dateString);
    
    cell.dateLabel.text = dateString;
    [cell.dateLabel sizeToFit];
    
    return cell;
}

/*
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}
*/

- (IBAction)editButton:(id)sender {
    UIButton *senderButton = (UIButton *)sender;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:senderButton.tag inSection:0];
    XYZPostCell *cell = (XYZPostCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    //NSLog(@"edit button equal to: %@", senderButton.titleLabel.text);

    if ([senderButton.titleLabel.text isEqualToString:@"Edit"]) {
        //[self.tableView setEditing:YES];
        [self.tableView setScrollEnabled:NO];
        [senderButton setTitle:@"Done" forState:UIControlStateNormal];
        [cell.postTextBox setEditable:YES];
        [cell.postTextBox becomeFirstResponder];
        
    }
    else {
        [senderButton setTitle:@"Edit" forState:UIControlStateNormal];
        //[self.tableView setEditing:NO];
        [cell.postTextBox setEditable:NO];
        [cell.postTextBox resignFirstResponder];
        [self.tableView setScrollEnabled:YES];
        NSString *editID = postIDs[indexPath.row];
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/post/edit"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     editID, @"postid",
                                     cell.postTextBox.text, @"message",
                                     [NSString stringWithFormat:@"%d", appDelegate.userSettings.postTime], @"timeout",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        if (error) {
            NSLog(@"First error: %@", [error localizedDescription]);
            return;
        }
        NSLog(@"OLD POST: %@", myPosts[indexPath.row]);
        if ([post_string rangeOfString:@"true"].location == NSNotFound) {
            cell.postTextBox.text = myPosts[indexPath.row];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not edit post" message:@"Something went wrong. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }

        
        
        
    }
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    XYZPostCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *at = @"@";
    NSString *temp = [at stringByAppendingString:appDelegate.userSettings.username];
    if ([cell.userLabel.text isEqualToString:temp]) {
        return YES;
    }
    else {
        return NO;
    }
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSString *removeID = postIDs[indexPath.row];
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/post/remove"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     removeID, @"postid",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            [postIDs removeObjectAtIndex:indexPath.row];
            [myPosts removeObjectAtIndex:indexPath.row];
            [firstNames removeObjectAtIndex:indexPath.row];
            [userNames removeObjectAtIndex:indexPath.row];
            [dates removeObjectAtIndex:indexPath.row];
            // Delete the row from the data source
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
    }
}


@end
