//
//  XYZContactView.m
//  iOS App
//
//  Created by John Nowotny on 4/8/14.
//
//

#import "XYZContactView.h"
#import "XYZAppDelegate.h"
#import <QuartzCore/QuartzCore.h>

@interface XYZContactView ()

@end

@implementation XYZContactView

@synthesize firstName, userName, phoneNumber, isBlocked, isSponsor;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    //if ([phoneNumber isEqual:[NSNull null]])
    
    //NSLog(@"%@", self.phoneButton.titleLabel.text);
    if ([phoneNumber isEqual:[NSNull null]]) {
        [self.phoneButton setTitle:@"" forState:UIControlStateNormal];
        [self.phoneButton setEnabled:NO];
    }
    else if ([phoneNumber isEqualToString:@"undefined"]) {
        [self.phoneButton setTitle:@"" forState:UIControlStateNormal];
        [self.phoneButton setEnabled:NO];
    }
    else {
        NSMutableString *formattedNumber = [NSMutableString stringWithString:phoneNumber];
        [formattedNumber insertString:@"(" atIndex:0];
        [formattedNumber insertString:@")" atIndex:4];
        [formattedNumber insertString:@" " atIndex:5];
        [formattedNumber insertString:@"-" atIndex:9];
        
        [self.phoneButton setTitle:formattedNumber forState:UIControlStateNormal];
        [self.phoneButton sizeToFit];
        [self.phoneButton setEnabled:YES];
    }
    self.firstNameLabel.text = firstName;
    self.usernameLabel.text = userName;
    [self.blockUserSwitch setOn:isBlocked];
    [self.sponsorSwitch setOn:isSponsor];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)makeCall:(id)sender {
    //UIApplication *myApp = [UIApplication sharedApplication];
    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    //NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
    //[myApp openURL:telURL];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", cleanedString]]];

}

- (IBAction)block:(id)sender {
    if (isBlocked) {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/userblock/remove"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"username",
                                     userName, @"blockeduser",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"contacts: %@", post_string);
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            [self.blockUserSwitch setOn:NO];
            isBlocked = FALSE;
        }
        else {
            [self.blockUserSwitch setOn:YES];
            isBlocked = TRUE;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot unblock user" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
 
    }
    else {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/userblock/new"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"username",
                                     userName, @"blockeduser",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"contacts: %@", post_string);
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            [self.blockUserSwitch setOn:YES];
            isBlocked = TRUE;
        }
        else {
            [self.blockUserSwitch setOn:NO];
            isBlocked = FALSE;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot block user" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}

- (IBAction)setSponsor:(id)sender {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    if (!isSponsor) {
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/member/edit"]];
        
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"oldusername",
                                     appDelegate.userSettings.username, @"username",
                                     appDelegate.userSettings.firstname, @"firstname",
                                     appDelegate.userSettings.password, @"password",
                                     userName, @"sponsorid",
                                     appDelegate.userSettings.email, @"email",
                                     appDelegate.userSettings.phoneNumber, @"phonenumber",
                                     [NSString stringWithFormat:@"%d", (appDelegate.userSettings.showPhone ? 1 : 0) ], @"displayphonenumber",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"BOOM: %@", post_string);
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            [self.sponsorSwitch setOn:YES];
            isSponsor = TRUE;
            appDelegate.userSettings.setSponsor = userName;
        }
        else {
            [self.sponsorSwitch setOn:NO];
            isSponsor = FALSE;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot set user as sponsor" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
    else {
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://54.187.99.187:80/member/edit"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"oldusername",
                                     appDelegate.userSettings.username, @"username",
                                     appDelegate.userSettings.firstname, @"firstname",
                                     appDelegate.userSettings.password, @"password",
                                     @"", @"sponsorid",
                                     appDelegate.userSettings.email, @"email",
                                     appDelegate.userSettings.phoneNumber, @"phonenumber",
                                     [NSString stringWithFormat:@"%d", (appDelegate.userSettings.showPhone ? 1 : 0) ], @"displayphonenumber",
                                     nil];
        NSError *error;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"BOOM2: %@", post_string);
        if (error) {
            return;
            NSLog(@"First error: %@", [error localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            [self.sponsorSwitch setOn:NO];
            isSponsor = FALSE;
            appDelegate.userSettings.setSponsor = @"";
        }
        else {
            [self.sponsorSwitch setOn:YES];
            isSponsor = TRUE;
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot unset user as sponsor" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
