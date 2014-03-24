//
//  XYZAppDelegate.m
//  iOS App
//
//  Created by John Patrick Nowotny on 2/12/14.
//
//

#import "XYZAppDelegate.h"
#import "XYZProximityViewViewController.h"
#import "SBJson4.h"
#import "SBJson4Parser.h"


@implementation XYZAppDelegate

@synthesize locationManager=_locationManager;


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
    
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // Perform request and get JSON back as a NSData object
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];

    if ([json_string rangeOfString:@"ZERO_RESULTS"].location == NSNotFound) {
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Test" message:@"High risk area!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        // Display Alert Message
        [messageAlert show];
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    //If object has not been created, create it.
    if(self.locationManager==nil){
        _locationManager=[[CLLocationManager alloc] init];
        //I'm using ARC with this project so no need to release
        
        _locationManager.delegate=self;
        
        //The desired accuracy that you want, not guaranteed though
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        
        self.locationManager=_locationManager;
    }
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [self.locationManager stopMonitoringSignificantLocationChanges];
}

@end
