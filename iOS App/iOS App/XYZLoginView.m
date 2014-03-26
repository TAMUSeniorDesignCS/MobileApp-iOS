//
//  XYZLoginView.m
//  iOS App
//
//  Created by John Nowotny on 3/5/14.
//
//

#import "XYZLoginView.h"

@interface XYZLoginView ()

@end

@implementation XYZLoginView

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
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
                                 self.Username.text, @"username",
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

    /*
    NSString *url = [NSString stringWithFormat:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/member/auth?username=%@&password=%@",self.Username.text,self.Password.text];
    
	NSLog(@"usr is %@", url);
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // Error
    NSError *error;
    // Perform request and get JSON back as a NSData object
    NSData *authData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *authReturn = [[NSString alloc] initWithData:authData encoding:NSUTF8StringEncoding];
    NSLog(@"post string is %@", authReturn);
    */
    
    if (error) {
        NSLog(@"error: %@", [error localizedDescription]);
    }
    else{
        if (![authReturn isEqualToString:@"NO"]) {
            [self performSegueWithIdentifier:@"tabBarPush" sender:nil];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot login" message:@"Username and/or password not recognized." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (void)viewDidLoad
{
    [_Username becomeFirstResponder];
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
