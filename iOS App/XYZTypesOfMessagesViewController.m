//
//  XYZTypesOfMessagesViewController.m
//  iOS App
//
//  Created by Sujin Lee on 3/24/14.
//
//

#import "XYZTypesOfMessagesViewController.h"

@interface XYZTypesOfMessagesViewController ()

@end

@implementation XYZTypesOfMessagesViewController

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL religiousState = [defaults boolForKey:@"rel"];
    if (religiousState) self.religiousCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else self.religiousCell.accessoryType = UITableViewCellAccessoryNone;
    
    
    BOOL funnyState = [defaults boolForKey:@"fun"];
    if (funnyState) self.funnyCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else self.funnyCell.accessoryType = UITableViewCellAccessoryNone;
    
    BOOL inspirationalState = [defaults boolForKey:@"ins"];
    if (inspirationalState) self.inspirationalCell.accessoryType = UITableViewCellAccessoryCheckmark;
    else self.inspirationalCell.accessoryType = UITableViewCellAccessoryNone;

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
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //INDEX KEY 0:RELIGIOUS
    //1:FUNNY
    //2:INSPIRATIONAL
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        if (indexPath.row == 0) [defaults setBool:FALSE forKey:@"rel"];
        else if (indexPath.row == 1) [defaults setBool:FALSE forKey:@"fun"];
        else if (indexPath.row == 2) [defaults setBool:FALSE forKey:@"ins"];
        [defaults synchronize];
    }
    else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        if (indexPath.row == 0) [defaults setBool:TRUE forKey:@"rel"];
        else if (indexPath.row == 1) [defaults setBool:TRUE forKey:@"fun"];
        else if (indexPath.row == 2) [defaults setBool:TRUE forKey:@"ins"];
        [defaults synchronize];
    }
}




@end
