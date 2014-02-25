//
//  XYZTabBarViewController.m
//  iOS App
//
//  Created by John Nowotny on 2/24/14.
//
//

#import "XYZTabBarViewController.h"

@interface XYZTabBarViewController ()

@end

@implementation XYZTabBarViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
    self.navigationItem.hidesBackButton = YES;
}


@end
