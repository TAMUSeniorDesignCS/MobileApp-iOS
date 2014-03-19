//
//  XYZSecondViewController.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import "XYZSecondViewController.h"

@interface XYZSecondViewController ()

@end

@implementation XYZSecondViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    myPosts = [[NSMutableArray alloc] init];

    //[self refreshPost];
    // Do any additional setup after loading the view, typically from a nib.

}

-(void)refreshPost{
    NSString *url = [NSString stringWithFormat:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/post/refresh"];
    
	NSLog(@"usr is %@", url);
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // Perform request and get JSON back as a NSData object
    NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Error
    NSError *error;
    // Parse JSON
    NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error];
    
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    else{
        for(NSDictionary *dict in array){
            [myPosts addObject:dict[@"message"]];
        }
    }
    
    // Get JSON as a NSString from NSData response
    NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
	NSLog(@"post string is %@", post_string);
    [self.tableView reloadData];

}

-(void)viewWillAppear:(BOOL)animated{
    //[myPosts removeAllObjects];
    [self refreshPost];
    [self.tableView reloadData];
    //[self.tableView numberOfRowsInSection:[myPosts count]];
    //[self.tableView cellForRowAtIndexPath:[myPosts ]];
    
    

}

-(void)viewWillDisappear:(BOOL)animated{
     [myPosts removeAllObjects];
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
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [myPosts objectAtIndex:indexPath.row];
    // Configure the cell...
    
    return cell;
}

@end
