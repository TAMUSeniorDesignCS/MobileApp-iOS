//
//  XYZNewPost.m
//  iOS App
//
//  Created by John Nowotny on 3/31/14.
//
//

#import "XYZNewPost.h"

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
    [_deleteTime resignFirstResponder];
    _deleteTime.text = @"48";
}

-(void)deleteDoneWithNumberPad{
    NSString *deleteNumberFromTheKeyboard = _deleteTime.text;
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
