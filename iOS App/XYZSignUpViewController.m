//
//  XYZSignUpViewController.m
//  iOS App
//
//  Created by Sujin Lee on 3/13/14.
//
//

#import "XYZSignUpViewController.h"

@interface XYZSignUpViewController ()

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
    return YES;
}

-(IBAction)clickedBackground{
    [self.view endEditing:YES];
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

- (IBAction)pressOKButton:(id)sender {
}


@end
