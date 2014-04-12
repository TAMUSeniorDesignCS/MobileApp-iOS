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
    UIApplication *myApp = [UIApplication sharedApplication];
    NSString *cleanedString = [[phoneNumber componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789-+()"] invertedSet]] componentsJoinedByString:@""];
    NSURL *telURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", cleanedString]];
    [myApp openURL:telURL];
}

- (IBAction)block:(id)sender {
    if (isBlocked) {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/userblock/remove"]];
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
        if (!([post_string rangeOfString:@"true"].location == NSNotFound))
            [self.blockUserSwitch setOn:NO];
        else {
            [self.blockUserSwitch setOn:YES];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot unblock user" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
 
    }
    else {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/userblock/new"]];
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
        if (!([post_string rangeOfString:@"true"].location == NSNotFound))
            [self.blockUserSwitch setOn:YES];
        else {
            [self.blockUserSwitch setOn:NO];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Cannot block user" message:@"Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
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
