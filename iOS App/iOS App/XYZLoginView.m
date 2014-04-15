//
//  XYZLoginView.m
//  iOS App
//
//  Created by John Nowotny on 3/5/14.
//
//

#import "XYZLoginView.h"
#import "XYZAppDelegate.h"

@interface XYZLoginView ()

@end

@implementation XYZLoginView

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField == _Username) {
		[textField resignFirstResponder];
		[_Password becomeFirstResponder];
	}
	else if (textField == _Password) {
		[textField resignFirstResponder];
	}
    
    return YES;
}

/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/
- (IBAction)clickedBackground:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)pressLoginButton:(id)sender{
    
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/member/auth"]];
    
    NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 [self.Username.text lowercaseString], @"username",
                                 self.Password.text, @"password",
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
        NSError *error2;
        NSMutableArray *array = [NSJSONSerialization JSONObjectWithData:authData options:NSJSONReadingMutableContainers error:&error2];
        //NSLog(@"group id is: %@", user_info[@"groupid"]);
        if (error2) {
            return;
            NSLog(@"Second error: %@", [error2 localizedDescription]);
        }
        
        NSDictionary *user_info = array[0];
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        appDelegate.userSettings.password = self.Password.text;
        appDelegate.userSettings.firstname = [user_info[@"firstname"] capitalizedString];
        appDelegate.userSettings.phoneNumber = user_info[@"phonenumber"];
        if (user_info[@"displayphonenumber"] == 1)
            appDelegate.userSettings.showPhone = TRUE;
        else
            appDelegate.userSettings.showPhone = FALSE;
        appDelegate.userSettings.email = user_info[@"email"];
        appDelegate.userSettings.username = [self.Username.text lowercaseString];
        appDelegate.userSettings.groupId = [user_info[@"groupid"] intValue];
        NSLog(@"group id i: %d", appDelegate.userSettings.groupId);
        appDelegate.userSettings.setSponsor = user_info[@"sponsorid"];
        appDelegate.userSettings.religiousOn = FALSE;
        appDelegate.userSettings.funnyOn = FALSE;
        appDelegate.userSettings.inspirationalOn = TRUE;
        //NSLog(@"group id is: %i", appDelegate.userSettings.groupId);
        [self performSegueWithIdentifier:@"tabBarPush" sender:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot login" message:@"Username and/or password not recognized." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

- (void)viewDidLoad
{
    //[_Username becomeFirstResponder];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
