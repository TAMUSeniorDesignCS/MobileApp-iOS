//
//  XYZTypesOfMessagesViewController.h
//  iOS App
//
//  Created by Sujin Lee on 3/24/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZTypesOfMessagesViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableViewCell *religiousCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *funnyCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *inspirationalCell;

@end
