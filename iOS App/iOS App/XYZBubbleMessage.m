//
//  XYZBubbleMessage.m
//  iOS App
//
//  Created by Sujin Lee on 4/7/14.
//
//

#import "XYZBubbleMessage.h"
#import "XYZAppDelegate.h"
#import "UIBubbleTableView.h"
#import "UIBubbleTableViewDataSource.h"
#import "NSBubbleData.h"

@interface XYZBubbleMessage (){
    NSMutableArray *bubbleData;
}

@end

@implementation XYZBubbleMessage

@synthesize chatBuddyName ,chatData;

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
    //chatData = [[NSMutableDictionary alloc] init];
    userNames = [[NSMutableArray alloc] init];
    dates = [[NSMutableArray alloc] init];
    messages = [[NSMutableArray alloc] init];
    messageIDs = [[NSMutableArray alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    animated = NO;
    [self refreshMessages];
    [self.bubbleTable reloadData];
}

-(void)viewWillDisappear:(BOOL)animated{
    [bubbleData removeAllObjects];
    [chatData removeAllObjects];
    [userNames removeAllObjects];
    [dates removeAllObjects];
    [messages removeAllObjects];
    [messageIDs removeAllObjects];
}

-(void)refreshMessages{
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    bubbleData = [[NSMutableArray alloc] init];
    
    for(NSDictionary *dict in chatData){
        if (dict[@"valid"]);
        else if ([[dict[@"receiversusername"] lowercaseString] isEqualToString:chatBuddyName] || [[dict[@"username"] lowercaseString] isEqualToString:chatBuddyName]){
            NSLog(@"username %@", chatBuddyName);
            NSLog(@"receivername %@", dict[@"receiversusername"]);

            NSString *str = dict[@"dateposted"];
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"YYYY-MM-dd'T'HH:mm:ss'.000Z'"];
            NSDate *dte = [dateFormat dateFromString:str];
            
            if ([dict[@"username"] isEqualToString:appDelegate.userSettings.username]){
                NSBubbleData *heyBubble = [NSBubbleData dataWithText:dict[@"message"] date:dte type:BubbleTypeMine];
                heyBubble.avatar = nil;
                [bubbleData addObject:heyBubble];
            }
            else{
                NSBubbleData *heyBubble = [NSBubbleData dataWithText:dict[@"message"] date:dte type:BubbleTypeSomeoneElse];
                heyBubble.avatar = nil;
                [bubbleData addObject:heyBubble];
            }
            //heyBubble.avatar = nil;
            //[bubbleData addObject:heyBubble];
            NSLog(@"directmessageid is %d", [dict[@"directmessageid"] integerValue]);
            NSLog(@"message is %@", dict[@"message"]);
        }
    }
    
    _bubbleTable.bubbleDataSource = self;
    
    // The line below sets the snap interval in seconds. This defines how the bubbles will be grouped in time.
    // Interval of 120 means that if the next messages comes in 2 minutes since the last message, it will be added into the same group.
    // Groups are delimited with header which contains date and time for the first message in the group.
    
    _bubbleTable.snapInterval = 120;
    
    // The line below enables avatar support. Avatar can be specified for each bubble with .avatar property of NSBubbleData.
    // Avatars are enabled for the whole table at once. If particular NSBubbleData misses the avatar, a default placeholder will be set (missingAvatar.png)
    
    _bubbleTable.showAvatars = NO;
    
    // Uncomment the line below to add "Now typing" bubble
    // Possible values are
    //    - NSBubbleTypingTypeSomebody - shows "now typing" bubble on the left
    //    - NSBubbleTypingTypeMe - shows "now typing" bubble on the right
    //    - NSBubbleTypingTypeNone - no "now typing" bubble
    
    //_bubbleTable.typingBubble = NSBubbleTypingTypeSomebody;
    
    [_bubbleTable reloadData];
    
    // Keyboard events
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:) name:UIKeyboardWillHideNotification object:nil];
    
    NSIndexPath *ipath = [NSIndexPath indexPathForRow:([_bubbleTable numberOfRowsInSection:([_bubbleTable numberOfSections]-1)] - 1) inSection:([_bubbleTable numberOfSections]-1)];
    [_bubbleTable scrollToRowAtIndexPath:ipath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
	// Do any additional setup after loading the view.

}

- (IBAction)sendButtonPushed:(id)sender {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *timeout;
    if (appDelegate.userSettings.messageTimeoutOn)
        timeout = [NSString stringWithFormat:@"%d", appDelegate.userSettings.messageTime];
    else
        timeout = @"0";
    NSMutableURLRequest *request = [NSMutableURLRequest
                                    requestWithURL:[NSURL URLWithString:@"http://ec2-54-201-163-32.us-west-2.compute.amazonaws.com:80/directmessage/new"]];
    NSDictionary *requestDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                 appDelegate.userSettings.username, @"rusername",
                                 appDelegate.userSettings.password, @"rpassword",
                                 _textField.text, @"message",
                                 timeout, @"timeout",
                                 appDelegate.userSettings.username, @"username",
                                 chatBuddyName, @"receiversusername",
                                 nil];
    NSError *error;
    NSData *requestData = [NSJSONSerialization dataWithJSONObject:requestDict options:0 error:nil];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:requestData];
    NSData *postData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    NSString *post_string = [[NSString alloc] initWithData:postData encoding:NSUTF8StringEncoding];
    
    NSLog(@"result: %@", post_string);
    
    NSLog(@"Direct message: %@", post_string);
    if (error) {
        return;
        NSLog(@"First error: %@", [error localizedDescription]);
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - UIBubbleTableViewDataSource implementation

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return [bubbleData count];
}

- (NSInteger)numberOfSections:(UIBubbleTableView *)tableView
{
    return 1;
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return [bubbleData objectAtIndex:row];
}

#pragma mark - Actions
- (IBAction)sendPressed:(id)sender {
    _bubbleTable.typingBubble = NSBubbleTypingTypeNobody;
    
    NSBubbleData *sayBubble = [NSBubbleData dataWithText:_textField.text date:[NSDate dateWithTimeIntervalSinceNow:0] type:BubbleTypeMine];
    [bubbleData addObject:sayBubble];
    [_bubbleTable reloadData];
    
    _textField.text = @"";
    [_textField resignFirstResponder];
    
    //NSLog(@"number of rows in section 0: %i", bubbleData.count);
    NSIndexPath *ipath = [NSIndexPath indexPathForRow:([_bubbleTable numberOfRowsInSection:([_bubbleTable numberOfSections]-1)] - 1) inSection:([_bubbleTable numberOfSections]-1)];
    [_bubbleTable scrollToRowAtIndexPath:ipath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
