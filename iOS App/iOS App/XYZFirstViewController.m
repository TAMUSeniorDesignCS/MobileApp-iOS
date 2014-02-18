//
//  XYZFirstViewController.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import "XYZFirstViewController.h"

@interface XYZFirstViewController () {
    
	CLGeocoder *geocoder;
	CLPlacemark *placemark;
}

@end

@implementation XYZFirstViewController

-(NSString *) getValueBetweenElement:(NSString *) element inHTML:(NSString *) html {
    NSString *result = nil;
    
    // Determine element location
    NSRange elementRange = [html rangeOfString:[NSString stringWithFormat:@"<%@>", element] options:NSCaseInsensitiveSearch];
    if (elementRange.location != NSNotFound)
    {
        // Determine end tag location based on beggining tag location
        NSRange endElementRange;
        
        endElementRange.location = elementRange.length + elementRange.location;
        endElementRange.length   = [html length] - endElementRange.location;
        endElementRange = [html rangeOfString:[NSString stringWithFormat:@"</%@>", element] options:NSCaseInsensitiveSearch range:endElementRange];
        
        if (endElementRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            elementRange.location += elementRange.length;
            elementRange.length = endElementRange.location - elementRange.location;
            
            result = [html substringWithRange:elementRange];
        }
    }
    return result;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //For the QUOTE......................
    NSString *fullURL = @"http://www.aa.org/lang/en/aareflections.cfm";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSError *error;
    NSString *page = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    NSString *quote = nil;
    // Determine the italic location
    NSRange elementRange = [page rangeOfString:[NSString stringWithFormat:@"<i>"] options:NSCaseInsensitiveSearch];
    if (elementRange.location != NSNotFound)
    {
        // Determine end tag location based on beggining tag location
        NSRange endElementRange;
        endElementRange.location = elementRange.length + elementRange.location;
        endElementRange.length   = [page length] - endElementRange.location;
        endElementRange = [page rangeOfString:[NSString stringWithFormat:@"</i>"] options:NSCaseInsensitiveSearch range:endElementRange];
        if (endElementRange.location != NSNotFound)
        {
            // Tags found: retrieve string between them
            elementRange.location += elementRange.length;
            elementRange.length = endElementRange.location - elementRange.location;
            quote = [page substringWithRange:elementRange];
        }
    }
    //..........................
    
    //For GEOFENCING....................
    locationManager = [[CLLocationManager alloc] init];
	locationManager.delegate = self;
	locationManager.distanceFilter = kCLDistanceFilterNone;
	locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //...............

    
    [_viewWeb loadHTMLString:quote baseURL:nil];
}


- (IBAction)getlocation:(id)sender
{
	
    if (self.geoSwitch.isOn)
    {
        [locationManager startUpdatingLocation];
    }
    else
    {
        [locationManager stopUpdatingLocation];
    }
         
}


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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callSponsor:(id)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://8004664411"]];

}

@end
