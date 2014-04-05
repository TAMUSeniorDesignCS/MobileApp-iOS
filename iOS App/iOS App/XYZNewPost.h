//
//  XYZNewPost.h
//  iOS App
//
//  Created by John Nowotny on 3/31/14.
//
//

#import <UIKit/UIKit.h>
#import "XYZSecondViewController.h"

@interface XYZNewPost : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UITextField *deleteTime;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property(nonatomic,assign) XYZSecondViewController *_postView;

@end
