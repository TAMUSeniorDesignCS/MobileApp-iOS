//
//  XYZProximityViewViewController.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/19/14.
//
//

#import "XYZProximityViewViewController.h"
#import "XYZAppDelegate.h"


@interface XYZProximityViewViewController () {
    
    CLGeocoder *geocoder;
	CLPlacemark *placemark;
    
}

@end

@implementation XYZProximityViewViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style ];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    
    [super viewDidLoad];
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;

    [self.geoSwitch setOn:appDelegate.userSettings.geoAlerts];
    if (self.geoSwitch.isOn) {
        [self.TypesOfMessages setHidden:FALSE];
        [self.SponsorNotification setHidden:FALSE];
        [self.sponsorSwitch setOn:appDelegate.userSettings.sponsorNotify];
    }
    else {
        [self.TypesOfMessages setHidden:TRUE];
        [self.SponsorNotification setHidden:TRUE];
        appDelegate.userSettings.sponsorNotify = FALSE;
        [self.sponsorSwitch setOn:FALSE];
    }
    /*
	// Do any additional setup after loading the view.
    //For GEOFENCING....................
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	//locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //...............
     */
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getlocation:(id)sender {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.userSettings.geoAlerts)
    {
        //[locationManager startMonitoringSignificantLocationChanges];
        //[locationManager startUpdatingLocation];
        appDelegate.userSettings.geoAlerts = TRUE;
        [appDelegate.locationManager startMonitoringSignificantLocationChanges];
        [self.TypesOfMessages setHidden:FALSE];
        [self.SponsorNotification setHidden:FALSE];
        [self.geoSwitch setOn:TRUE];
        
    }
    else
    {
        //[locationManager stopMonitoringSignificantLocationChanges];
        //[locationManager stopUpdatingLocation];
        appDelegate.userSettings.geoAlerts = FALSE;
        [appDelegate.locationManager stopMonitoringSignificantLocationChanges];
        [self.TypesOfMessages setHidden:TRUE];
        [self.SponsorNotification setHidden:TRUE];
        [self.sponsorSwitch setOn:NO];
        appDelegate.userSettings.sponsorNotify = FALSE;
        [self.geoSwitch setOn:FALSE];
    }
}

- (IBAction)sponsorNotify:(id)sender {
    XYZAppDelegate *appDelegate=(XYZAppDelegate *)[UIApplication sharedApplication].delegate;
    if (!appDelegate.userSettings.sponsorNotify)
    {
        appDelegate.userSettings.sponsorNotify = TRUE;
        [self.sponsorSwitch setOn:TRUE];
    }
    else
    {
        appDelegate.userSettings.sponsorNotify = FALSE;
        [self.sponsorSwitch setOn:false];
    }

}


/*
// Failed to get current location
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	
    UIAlertView *errorAlert = [[UIAlertView alloc]
							   initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    // Call alert
	[errorAlert show];
}

// Got location and now update
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
	
    CLLocation *currentLocation = newLocation;
    NSNumber *latitude = [NSNumber numberWithDouble:currentLocation.coordinate.latitude];
    NSNumber *longitude = [NSNumber numberWithDouble:currentLocation.coordinate.longitude];
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/radarsearch/json?location=%@,%@&rankby=distance&types=bar&radius=17&sensor=true&key=AIzaSyAkU63FTdiEiaahe4x-9oZ_fJ0qrZQAcZ0",latitude,longitude];
    
	NSLog(@"%@", url);
	
}
 */

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


@end
