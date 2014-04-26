//
//  XYZNewPost.m
//  iOS App
//
//  Created by John Nowotny on 3/31/14.
//
//

#import "XYZNewPost.h"
#import "XYZAppDelegate.h"
#import "XYZSecondViewController.h"


@interface XYZNewPost ()

@end

@implementation XYZNewPost

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
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    _deleteTime.text = [NSString stringWithFormat:@"%d", appDelegate.userSettings.postTime];
    
    self.text.layer.borderWidth = 5.0f;
    self.text.layer.borderColor = [[UIColor grayColor] CGColor];
    self.text.layer.cornerRadius = 8;
    
    UIToolbar* deleteNumberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    deleteNumberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(deleteCancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(deleteDoneWithNumberPad)],
                               nil];
    
    _deleteTime.inputAccessoryView = deleteNumberToolbar;
    
    UIToolbar* textToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    textToolbar.items = [NSArray arrayWithObjects:
                                 [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(textCancelNumberPad)],
                                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                 [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textDoneWithNumberPad)],
                                 nil];
    
    _text.inputAccessoryView = textToolbar;

    // Do any additional setup after loading the view.
}

-(void)deleteCancelNumberPad{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    [_deleteTime resignFirstResponder];
    _deleteTime.text = [NSString stringWithFormat:@"%d", appDelegate.userSettings.postTime];
}

-(void)deleteDoneWithNumberPad{
    [_deleteTime resignFirstResponder];
}

-(void)textCancelNumberPad{
    [_text resignFirstResponder];
}

-(void)textDoneWithNumberPad{
    NSString *textNumberFromTheKeyboard = _text.text;
    [_text resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)submitPost:(id)sender {
    if (![self.text.text isEqual: @""]) {
        XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
        NSMutableURLRequest *request = [NSMutableURLRequest
                                        requestWithURL:[NSURL URLWithString:@"https://paulgreco.net/post/new"]];
        
        NSDictionary *requestData = [[NSDictionary alloc] initWithObjectsAndKeys:
                                     appDelegate.userSettings.username, @"rusername",
                                     appDelegate.userSettings.password, @"rpassword",
                                     appDelegate.userSettings.username, @"username",
                                     self.text.text, @"message",
                                     self.deleteTime.text, @"timeout",
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
           
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Could not post" message:@"Something went wrong. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
        }
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nothing to post" message:@"Cannot post nothing." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
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
