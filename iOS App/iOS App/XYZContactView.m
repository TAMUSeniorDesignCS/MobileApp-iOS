//
//  XYZContactView.m
//  iOS App
//
//  Created by John Nowotny on 4/8/14.
//
//

#import "XYZContactView.h"
#import <QuartzCore/QuartzCore.h>

@interface XYZContactView ()

@end

@implementation XYZContactView

@synthesize firstName, userName, phoneNumber;

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
    
    [self.phoneButton setTitle:phoneNumber forState:UIControlStateNormal];
    if ([self.phoneButton.titleLabel.text  isEqual: @""])
        [self.phoneButton setEnabled:NO];
    else
        [self.phoneButton setEnabled:YES];
    self.firstNameLabel.text = firstName;
    self.usernameLabel.text = userName;
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
