//
//  XYZBubbleMessage.h
//  iOS App
//
//  Created by Sujin Lee on 4/7/14.
//
//

#import <UIKit/UIKit.h>
#import "UIBubbleTableViewDataSource.h"

@interface XYZBubbleMessage : UIViewController <UIBubbleTableViewDataSource>{
    NSString *chatBuddyName;
    NSMutableDictionary *chatData;
    NSMutableArray *userNames;
    NSMutableArray *messages;
    NSMutableArray *dates;
    NSMutableArray *messageIDs;
}
@property (weak, nonatomic) IBOutlet UIBubbleTableView *bubbleTable;
@property (weak, nonatomic) IBOutlet UIView *textInputView;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (strong, nonatomic) NSString *chatBuddyName;
@property (strong, nonatomic) NSMutableDictionary *chatData;

@end
