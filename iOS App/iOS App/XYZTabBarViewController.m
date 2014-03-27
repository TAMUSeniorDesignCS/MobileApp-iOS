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
    //[self.navigationController setNavigationBarHidden:YES animated:NO];
	// Do any additional setup after loading the view.
}
- (IBAction)newAction:(id)sender {
    if ([self.NewButton.title isEqualToString:@"New Post"]) {
        [self performSegueWithIdentifier:@"newPostPush" sender:nil];
    }
    if ([self.NewButton.title isEqualToString:@"New Message"]) {
        [self performSegueWithIdentifier:@"newMessagePush" sender:nil];
    }
}

/*
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    switch (self.selectedIndex) {
        case 1:
            self.NewButton.title = @"";
            self.NewButton.enabled = NO;
            break;
        case 2:
            self.NewButton.title = @"New Post";
            self.NewButton.enabled = YES;
            break;
        case 3:
            self.NewButton.title = @"New Message";
            self.NewButton.enabled = YES;
            break;
        case 4:
            self.NewButton.title = @"";
            self.NewButton.enabled = NO;
            break;
        case 5:
            self.NewButton.title = @"";
            self.NewButton.enabled = NO;
            break;
        default:
            break;
    }
}
*/
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
