//
//  XYZSignUpViewController.h
//  iOS App
//
//  Created by Sujin Lee on 3/13/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZSignUpViewController : UIViewController<UITextFieldDelegate>{
    IBOutlet UIScrollView *scroll;
}
@property (strong, nonatomic) IBOutlet UITextField *Username;
@property (strong, nonatomic) IBOutlet UITextField *FirstName;
@property (strong, nonatomic) IBOutlet UITextField *Password;
@property (strong, nonatomic) IBOutlet UITextField *VerifyPassword;
@property (strong, nonatomic) IBOutlet UITextField *GroupCode;
@property (strong, nonatomic) IBOutlet UIButton *OKButton;

-(BOOL) textFieldShouldReturn:(UITextField *)textField;
-(IBAction)clickedBackground;

@end
