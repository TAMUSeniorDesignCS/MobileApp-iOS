//
//  XYZAppDelegate.h
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface XYZAppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) CLLocationManager *locationManager;

@end
