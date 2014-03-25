//
//  XYZAppDelegate.h
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SBJson4.h"
#import "XYZUserSettings.h"


@interface XYZAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) XYZUserSettings *userSettings;

@end
