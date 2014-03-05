//
//  XYZTimeoutView.m
//  iOS App
//
//  Created by John Nowotny on 3/5/14.
//
//

#import "XYZTimeoutView.h"

@interface XYZTimeoutView ()

@end

@implementation XYZTimeoutView

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 4;
}

- (IBAction)postTimeout:(id)sender {
    
    if (self.PostSwitch.isOn)
    {
        [self.PostTimeout setHidden:FALSE];
    }
    else
    {
        [self.PostTimeout setHidden:TRUE];
    }
}

- (IBAction)messageTimeout:(id)sender {
    
    if (self.MessageSwitch.isOn)
    {
        [self.MessageTimeout setHidden:FALSE];
    }
    else
    {
        [self.MessageTimeout setHidden:TRUE];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

@end
