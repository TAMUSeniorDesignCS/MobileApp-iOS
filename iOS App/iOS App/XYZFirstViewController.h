//
//  XYZFirstViewController.h
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface XYZFirstViewController : UIViewController <CLLocationManagerDelegate>{
	
	CLLocationManager *locationManager;
	
}

@property (weak, nonatomic) IBOutlet UIWebView *viewWeb;
//@property (weak, nonatomic) IBOutlet UISwitch *geoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *geoSwitch;

@end
