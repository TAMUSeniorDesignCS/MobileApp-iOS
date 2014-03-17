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
    
    //---Number Keypad for Group Code---
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
    
    numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
    
    
    _GroupCode.inputAccessoryView = numberToolbar;
    
	// Do any additional setup after loading the view.
}

-(void)cancelNumberPad{
    [_GroupCode resignFirstResponder];
    _GroupCode.text = @"";
}

-(void)doneWithNumberPad{
    NSString *numberFromTheKeyboard = _GroupCode.text;
    [_GroupCode resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressOKButton:(id)sender {
}


@end
