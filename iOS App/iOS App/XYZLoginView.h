//
//  XYZLoginView.h
//  iOS App
//
//  Created by John Nowotny on 3/5/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZLoginView : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (strong, nonatomic) IBOutlet UITextField *UserName;
@property (strong, nonatomic) IBOutlet UITextField *Password;

-(BOOL) textFieldShouldReturn:(UITextField *)textField;
-(IBAction)clickedBackground;
@end
