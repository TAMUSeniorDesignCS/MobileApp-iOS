//
//  XYZMeetingFinder.h
//  iOS App
//
//  Created by John Nowotny on 4/12/14.
//
//

#import <UIKit/UIKit.h>

@interface XYZMeetingFinder : UIViewController <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *stopButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *refreshButton;

- (void)loadRequestFromString:(NSString*)urlString;
- (void)updateButtons;

@end
