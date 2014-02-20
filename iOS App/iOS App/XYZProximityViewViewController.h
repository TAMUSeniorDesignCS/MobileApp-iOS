//
//  XYZProximityViewViewController.h
//  iOS App
//
//  Created by John Patrick Nowotny on 2/19/14.
//
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface XYZProximityViewViewController : UITableViewController <CLLocationManagerDelegate>{
	
	CLLocationManager *locationManager;
	
}

@property (weak, nonatomic) IBOutlet UISwitch *geoSwitch;
@property (weak, nonatomic) IBOutlet UISwitch *sponsorSwitch;
@property (weak, nonatomic) IBOutlet UITableViewCell *TypesOfMessages;
@property (weak, nonatomic) IBOutlet UITableViewCell *SponsorNotification;


@end
