//
//  XYZSignUpViewController.m
//  iOS App
//
//  Created by Sujin Lee on 3/13/14.
//
//

#import "XYZSignUpViewController.h"
#import "XYZAppDelegate.h"
#import "TPKeyboardAvoidingScrollView.h"


@interface XYZSignUpViewController ()
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation XYZSignUpViewController

/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}*/

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    if (textField == _Username) {
		[textField resignFirstResponder];
		[_FirstName becomeFirstResponder];
	}
	else if (textField == _FirstName) {
		[textField resignFirstResponder];
		[_Password becomeFirstResponder];
	}
	else if (textField == _Password) {
		[textField resignFirstResponder];
		[_VerifyPassword becomeFirstResponder];
	}
    else if (textField == _VerifyPassword) {
		[textField resignFirstResponder];
		[_PhoneNumber becomeFirstResponder];
	}
    else if (textField == _PhoneNumber) {
		[textField resignFirstResponder];
		[_GroupCode becomeFirstResponder];
    }
    else if (textField == _GroupCode) {
		[textField resignFirstResponder];
	}
    return YES;
}

-(IBAction)clickedBackground{
    [self.view endEditing:YES];
}

- (void)viewDidLoad
{
    //[_Username becomeFirstResponder];
    [super viewDidLoad];
    
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.contentView.frame.size.height);
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    //---Number Keypad for Group Code---
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
    
    
    _GroupCode.inputAccessoryView = numberToolbar;
    
    UIToolbar* phoneToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    phoneToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Next" style:UIBarButtonItemStyleDone target:self action:@selector(nextOne)],
                           nil];
    
    _PhoneNumber.inputAccessoryView = phoneToolbar;
    
	// Do any additional setup after loading the view.
}

-(void)dismissKeyboard{
    [_Username resignFirstResponder];
    [_FirstName resignFirstResponder];
    [_Password resignFirstResponder];
    [_VerifyPassword resignFirstResponder];
    [_PhoneNumber resignFirstResponder];
    [_GroupCode resignFirstResponder];
}

-(void)cancelNumberPad{
    [_GroupCode resignFirstResponder];
    _GroupCode.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = _GroupCode.text;
    [_GroupCode resignFirstResponder];
}

-(void)nextOne{
    [_PhoneNumber resignFirstResponder];
    [_GroupCode becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressOKButton:(id)sender {
    
    if([self.Password.text isEqualToString:self.VerifyPassword.text]){ //passwords match!
    
        NSMutableURLRequest *requestGroup = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/aagroup/auth"]];
        
        NSDictionary *group_requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     self.GroupCode.text, @"groupid",
                                     nil];
        NSError *group_error;
        NSData *postgroupData = [NSJSONSerialization dataWithJSONObject:group_requestData options:0 error:&group_error];
        [requestGroup setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [requestGroup setHTTPMethod:@"POST"];
        [requestGroup setHTTPBody:postgroupData];
        NSData *groupData = [NSURLConnection sendSynchronousRequest:requestGroup returningResponse:nil error:&group_error];
        NSString *groupReturn = [[NSString alloc] initWithData:groupData encoding:NSUTF8StringEncoding];
        
        if (!([groupReturn rangeOfString:@"true"].location == NSNotFound)) {
        
           NSMutableURLRequest *request = [NSMutableURLRequest
                                           requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/member/new"]];
        
           NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     self.GroupCode.text, @"groupid",
                                     self.Password.text, @"password",
                                     [self.FirstName.text capitalizedString], @"firstname",
                                     [self.Username.text lowercaseString], @"username",
                                     @"", @"sponsorid",
                                     @"", @"email",
                                     nil];
           NSError *error;
           NSData *postData = [NSJSONSerialization dataWithJSONObject:requestData options:0 error:&error];
           [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
           [request setHTTPMethod:@"POST"];
           [request setHTTPBody:postData];
           NSData *authData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
           NSString *authReturn = [[NSString alloc] initWithData:authData encoding:NSUTF8StringEncoding];
           NSLog(@"post string is %@", authReturn);
        
        
           if (error) NSLog(@"error: %@", [error localizedDescription]);
           else{ //no error
            
               if (!([authReturn rangeOfString:@"true"].location == NSNotFound)) { //account created!
                 XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
                 
                 appDelegate.userSettings.username = [self.Username.text lowercaseString];
                 appDelegate.userSettings.firstname = [self.FirstName.text capitalizedString];
                 appDelegate.userSettings.showPhone = TRUE;
                 appDelegate.userSettings.showEmail = FALSE;
                 appDelegate.userSettings.geoAlerts = FALSE;
                 appDelegate.userSettings.religiousOn = FALSE;
                 appDelegate.userSettings.funnyOn = FALSE;
                 appDelegate.userSettings.inspirationalOn = TRUE;
                 appDelegate.userSettings.sponsorNotify = FALSE;
                 appDelegate.userSettings.postTimeoutOn = TRUE;
                 appDelegate.userSettings.postTime = 48;
                 appDelegate.userSettings.messageTimeoutOn = FALSE;
                 appDelegate.userSettings.messageTime = 48;
                 appDelegate.userSettings.setSponsor = @"";
                 
                 [self performSegueWithIdentifier:@"signUpPush" sender:nil];
               }
               else { //account signup went wrong
                   UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot signup" message:@"Account already exists." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                   [alertView show];
               }
           }
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot signup" message:@"Group code does not exist." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
   }
   else { //Passwords do not match
       UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot sign up" message:@"Passwords do not match." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
       [alertView show];
   }
}

@end
