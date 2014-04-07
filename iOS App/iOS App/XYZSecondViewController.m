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
    postIDs = [[NSMutableArray alloc] init];
    myPosts = [[NSMutableArray alloc] init];
    firstNames = [[NSMutableArray alloc] init];
    userNames = [[NSMutableArray alloc] init];
    dates = [[NSMutableArray alloc] init];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)refreshPost
{
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/post/refresh"]];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 @"1", @"groupid",
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
                if (dict[@"valid"]);
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
    static NSString *CellIdentifier = @"postCell";
    XYZPostCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[XYZPostCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...

    cell.postTextBox.text = [myPosts objectAtIndex:indexPath.row];
    cell.userLabel.text = [userNames objectAtIndex:indexPath.row];
    [cell.userLabel sizeToFit];
    cell.firstLabel.text = [firstNames objectAtIndex:indexPath.row];
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

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    XYZPostCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.userLabel.text isEqualToString:appDelegate.userSettings.username]) {
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
        
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/post/remove"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
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
