//
//  XYZPostCell.h
//  iOS App
//
//  Created by Sujin Lee on 4/2/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZPostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *firstLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UITextView *postTextBox;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;

@end
