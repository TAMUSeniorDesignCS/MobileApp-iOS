//
//  XYZBubbleMessage.h
//  iOS App
//
//  Created by Sujin Lee on 4/9/14.
//
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"

@interface XYZBubbleMessage : UIViewController <UIBubbleTableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *bubbleTable;
@property (strong, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
