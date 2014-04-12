//
//  XYZTypesOfMessagesViewController.m
//  iOS App
//
//  Created by Sujin Lee on 3/24/14.
//
//

#import "XYZTypesOfMessagesViewController.h"
#import "XYZAppDelegate.h"

@interface XYZTypesOfMessagesViewController ()

@end

@implementation XYZTypesOfMessagesViewController

@synthesize inspirationalCell, funnyCell, religiousCell;

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
    
	// Do any additional setup after loading the view.
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated {
    //INDEX KEY 0:RELIGIOUS
    //1:FUNNY
    //2:INSPIRATIONAL
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    //UITableViewCell *religious = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    //UITableViewCell *funny = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    //UITableViewCell *inspirational = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    
    if (appDelegate.userSettings.inspirationalOn)
        self.inspirationalCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        inspirationalCell.accessoryType = UITableViewCellAccessoryNone;
    
    if (appDelegate.userSettings.funnyOn)
        funnyCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        funnyCell.accessoryType = UITableViewCellAccessoryNone;
    
    if (appDelegate.userSettings.religiousOn)
        religiousCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else
        religiousCell.accessoryType = UITableViewCellAccessoryNone;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;

    //INDEX KEY 0:RELIGIOUS
    //1:FUNNY
    //2:INSPIRATIONAL
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 0) appDelegate.userSettings.religiousOn = FALSE;
        else if (indexPath.row == 1) appDelegate.userSettings.funnyOn = FALSE;
        else if (indexPath.row == 2) appDelegate.userSettings.inspirationalOn = FALSE;
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (indexPath.row == 0) appDelegate.userSettings.religiousOn = YES;
        else if (indexPath.row == 1) appDelegate.userSettings.funnyOn = TRUE;
        else if (indexPath.row == 2) appDelegate.userSettings.inspirationalOn = TRUE;
    }
}


@end
