//
//  XYZContactView.h
//  iOS App
//
//  Created by John Nowotny on 4/8/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZContactView : UIViewController {
    NSString *firstName;
    NSString *userName;
    NSString *phoneNumber;
    BOOL *isBlocked;
    BOOL *isSponsor;
}

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *phoneNumber;
@property (weak, nonatomic) NSString *displayPhone;
@property BOOL *isBlocked;
@property BOOL *isSponsor;
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UIButton *phoneButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UISwitch *sponsorSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *blockUserSwitch;




@end
