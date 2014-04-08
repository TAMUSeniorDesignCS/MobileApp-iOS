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
    self.phoneButton.layer.cornerRadius = 2;
    self.phoneButton.layer.borderWidth = 1;
    self.phoneButton.layer.borderColor = [UIColor blueColor].CGColor;
    [super viewDidLoad];
    [self.phoneButton setTitle:phoneNumber forState:UIControlStateNormal];
    self.firstNameLabel.text = firstName;
    self.usernameLabel.text = userName;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
