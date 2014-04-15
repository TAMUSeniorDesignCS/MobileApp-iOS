//
//  XYZFirstViewController.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import "XYZFirstViewController.h"
#import "XYZAppDelegate.h"

@interface XYZFirstViewController ()

@end

@implementation XYZFirstViewController {
    NSString *sponsorNumber;
}


-(NSString *) getValueBetweenElement:(NSString *) element inHTML:(NSString *) html {
    NSString *result = nil;
    
    // Determine element location
    NSRange elementRange = [html rangeOfString:[NSString stringWithFormat:@"<%@>", element] options:NSCaseInsensitiveSearch];
    if (elementRange.location != NSNotFound)
    {
        // Determine end tag location based on beggining tag location
        NSRange endElementRange;
        
        endElementRange.location = elementRange.length + elementRange.location;
        endElementRange.length   = [html length] - endElementRange.location;
        endElementRange = [html rangeOfString:[NSString stringWithFormat:@"</%@>", element] options:NSCaseInsensitiveSearch range:endElementRange];
        
        if (endElementRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            elementRange.location += elementRange.length;
            elementRange.length = endElementRange.location - elementRange.location;
            
            result = [html substringWithRange:elementRange];
        }
    }
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    sponsorNumber = @"";
    
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *user = [NSString stringWithFormat:@"Welcome %@", [appDelegate.userSettings.firstname capitalizedString]];
    [self.helloUser setText:user];
    
    //For the QUOTE......................
    NSString *fullURL = @"http://www.aa.org/lang/en/aareflections.cfm";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSError *error;
    NSString *page = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSString *quote = nil;
    // Determine the italic location
    NSRange elementRange = [page rangeOfString:[NSString stringWithFormat:@"<i>"] options:NSCaseInsensitiveSearch];
    if (elementRange.location != NSNotFound)
    {
        // Determine end tag location based on beggining tag location
        NSRange endElementRange;
        endElementRange.location = elementRange.length + elementRange.location;
        endElementRange.length   = [page length] - endElementRange.location;
        endElementRange = [page rangeOfString:[NSString stringWithFormat:@"</i>"] options:NSCaseInsensitiveSearch range:endElementRange];
        if (endElementRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            elementRange.location += elementRange.length;
            elementRange.length = endElementRange.location - elementRange.location;
            quote = [page substringWithRange:elementRange];
        }
    }
    [_quoteDay  setText:quote];
    /*
    if (![appDelegate.userSettings.setSponsor isEqualToString:@""]) {
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/member/getinfo"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     @"-1", @"groupid",
                                     appDelegate.userSettings.setSponsor, @"username",
                                     nil];
        NSError *errorData;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&errorData];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"sponsor info: %@", post_string);
        if (errorData) {
            return;
            NSLog(@"First error: %@", [errorData localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            NSError *error2;
            NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error2];
            if (error2) {
                return;
                NSLog(@"Second error: %@", [error2 localizedDescription]);
            }
            for(NSDictionary *dict in array){
                if (dict[@"valid"]);
                else {
                    //XYZUserSettings *user = [XYZUserSettings new];
                    //user.username = dict[@"username"];
                    //user.firstname = dict[@"firstname"];
                    //user.phoneNumber = dict[@"phonenumber"];
                    //[users addObject:user];
                    //sponsorNumber = dict[];
                }
            }
        }
    }
    */
    
}

- (void) viewWillAppear:(BOOL)animated {
    animated = NO;
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    self.tabBarController.navigationItem.rightBarButtonItem.title = @"";
    self.tabBarController.navigationItem.rightBarButtonItem.enabled = NO;
    if (![appDelegate.userSettings.setSponsor isEqualToString:@""]) {
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/member/getinfo"]];
        NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     @"-1", @"groupid",
                                     appDelegate.userSettings.setSponsor, @"username",
                                     nil];
        NSError *errorData;
        NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:requestData];
        NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&errorData];
        NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
        NSLog(@"sponsor info: %@", post_string);
        if (errorData) {
            return;
            NSLog(@"First error: %@", [errorData localizedDescription]);
        }
        if (!([post_string rangeOfString:@"true"].location == NSNotFound)) {
            NSError *error2;
            NSMutableDictionary *array = [NSJSONSerialization JSONObjectWithData:postData options:NSJSONReadingMutableContainers error:&error2];
            if (error2) {
                return;
                NSLog(@"Second error: %@", [error2 localizedDescription]);
            }
            for(NSDictionary *dict in array){
                if (dict[@"valid"]);
                else {
                    //XYZUserSettings *user = [XYZUserSettings new];
                    //user.username = dict[@"username"];
                    //user.firstname = dict[@"firstname"];
                    //user.phoneNumber = dict[@"phonenumber"];
                    //[users addObject:user];
                    sponsorNumber = dict[@"phonenumber"];
                }
            }
        }
        [self.callSponsor setHidden:FALSE];
        [self.callSponsor setEnabled:TRUE];
    }
    else {
        [self.callSponsor setHidden:TRUE];
        [self.callSponsor setEnabled:FALSE];
    }
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callSponsor:(id)sender
{
    NSString *phoneNumber = @"telprompt://";
    phoneNumber = [phoneNumber stringByAppendingString:sponsorNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
}

@end
