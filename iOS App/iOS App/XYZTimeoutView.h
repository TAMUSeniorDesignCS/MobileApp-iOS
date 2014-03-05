//
//  XYZTimeoutView.h
//  iOS App
//
//  Created by John Nowotny on 3/5/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZTimeoutView : UITableViewController
@property (weak, nonatomic) IBOutlet UISwitch *PostSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *MessageSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *PostTimeout;
@property (weak, nonatomic) IBOutlet UITableViewCell *MessageTimeout;


@end
