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
    
    if([self.Username.text isEqual:@"jnowotny"]) {
        [self performSegueWithIdentifier:@"tabBarPush" sender:nil];
    }else if([self.Username.text isEqual:@"sujin"]){
        [self performSegueWithIdentifier:@"tabBarPush" sender:nil];
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
