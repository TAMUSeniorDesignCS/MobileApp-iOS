//
//  XYZChangePasswordViewController.h
//  iOS App
//
//  Created by Sujin Lee on 2/24/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZChangePasswordViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *OKButton;
@property (strong, nonatomic) IBOutlet UITextField *OldPassword;
@property (strong, nonatomic) IBOutlet UITextField *NewPassword;
@property (strong, nonatomic) IBOutlet UITextField *ConfirmPassword;

-(BOOL) textFieldShouldReturn:(UITextField *)textField;
-(IBAction)clickedBackground;
@end
