//
//  XYZChangePasswordViewController.m
//  iOS App
//
//  Created by Sujin Lee on 2/24/14.
//
//

#import "XYZChangePasswordViewController.h"
#import "XYZAppDelegate.h"

@interface XYZChangePasswordViewController ()

@end

@implementation XYZChangePasswordViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField == _OldPassword) {
		[textField resignFirstResponder];
		[_NewPassword becomeFirstResponder];
	}
    else if (textField == _NewPassword) {
		[textField resignFirstResponder];
        [_ConfirmPassword becomeFirstResponder];
	}
	else if (textField == _ConfirmPassword) {
		[textField resignFirstResponder];
	}
    
    return YES;
}

-(IBAction)clickedBackground{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    //[_OldPassword becomeFirstResponder];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewDidUnload{
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressOKButton:(id)sender{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    if (![self.OldPassword.text isEqualToString:appDelegate.userSettings.password]) {
        //NSLog(@"user settingpassword is: %@", appDelegate.userSettings.password);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Old password incorrect" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if (![self.NewPassword.text isEqualToString:self.ConfirmPassword.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New passwords do not match." message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else if ([self.ConfirmPassword.text isEqualToString:self.OldPassword.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"New password is the same as old password." message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    else {
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/member/edit"]];
        
        NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"oldusername",
                                     appDelegate.userSettings.username, @"username",
                                     appDelegate.userSettings.firstname, @"firstname",
                                     self.NewPassword.text, @"password",
                                     appDelegate.userSettings.setSponsor, @"sponsorid",
                                     appDelegate.userSettings.email, @"email",
                                     appDelegate.userSettings.phoneNumber, @"phonenumber",
                                     [NSString stringWithFormat:@"%d", (appDelegate.userSettings.showPhone ? 1 : 0) ], @"displayphonenumber",
                                     nil];
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:postData];
        NSData *authData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *authReturn = [[NSString alloc] initWithData:authData encoding:NSUTF8StringEncoding];
        NSLog(@"post string is %@", authReturn);
        if (error) {
            NSLog(@"error: %@", [error localizedDescription]);
        }
        if (!([authReturn rangeOfString:@"true"].location == NSNotFound)) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Password changed!" message:@"Your password is now changed." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Something went wrong." message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            return;
        }
    }
}

@end
