//
//  XYZDefaultTimeoutViewController.h
//  iOS App
//
//  Created by Sujin Lee on 3/14/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZDefaultTimeoutViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *PostSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *MessageSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *PostHours;
@property (weak, nonatomic) IBOutlet UITableViewCell *MessageHours;
@property (weak, nonatomic) IBOutlet UITextField *PostTextfield;
@property (weak, nonatomic) IBOutlet UITextField *MessageTextfield;

@end
