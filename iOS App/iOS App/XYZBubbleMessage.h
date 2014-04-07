//
//  XYZBubbleMessage.h
//  iOS App
//
//  Created by Sujin Lee on 4/7/14.
//
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"

@interface XYZBubbleMessage : UIViewController <UIBubbleTableViewDataSource>
@property (weak, nonatomic) IBOutlet UIBubbleTableView *bubbleTable;
@property (weak, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end
