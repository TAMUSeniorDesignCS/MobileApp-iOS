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


@implementation XYZAppDelegate {
    NSArray *religiousMessages;
    NSArray *funnyMessages;
    NSArray *inspirationalMessages;
}

@synthesize locationManager=_locationManager;
@synthesize userSettings = _userSettings;


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
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/radarsearch/json?location=%@,%@&rankby=distance&types=bar&radius=100&sensor=true&key=AIzaSyAkU63FTdiEiaahe4x-9oZ_fJ0qrZQAcZ0",latitude,longitude];
    
	NSLog(@"%@", url);
    // Prepare URL request to download statuses from Twitter
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    // Perform request and get JSON back as a NSData object
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    // Get JSON as a NSString from NSData response
    NSString *json_string = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",json_string);
    if ([json_string rangeOfString:@"ZERO_RESULTS"].location == NSNotFound) {
        NSArray *typesMessage = [[NSArray alloc] init];
        if (self.userSettings.religiousOn)
            typesMessage = [typesMessage arrayByAddingObjectsFromArray:religiousMessages];
        if (self.userSettings.funnyOn)
            typesMessage = [typesMessage arrayByAddingObjectsFromArray:funnyMessages];
        if (self.userSettings.inspirationalOn)
            typesMessage = [typesMessage arrayByAddingObjectsFromArray:inspirationalMessages];
        NSString *alertMessage;
        if([typesMessage count] >= 1)
            alertMessage = [typesMessage objectAtIndex: arc4random() % [typesMessage count]];
        else
            alertMessage = @"You are in a high risk area!";
        NSLog(@"HIGH RISK!");
        /*
        UIAlertView *messageAlert = [[UIAlertView alloc]initWithTitle:@"Test" message:@"High risk area!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil,nil];
        // Display Alert Message
        [messageAlert show];
        */
        UIApplication *app = [UIApplication sharedApplication];
        UILocalNotification *notification = [[UILocalNotification alloc] init];
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        
        if (notification == nil)
            return;
        notification.alertBody = [NSString stringWithFormat:alertMessage];
        notification.alertAction = @"Ok";
        notification.soundName = UILocalNotificationDefaultSoundName;
        //notification.applicationIconBadgeNumber = 1;
        [app presentLocalNotificationNow:notification];
    }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    if (notification)
    {
        notification.applicationIconBadgeNumber += 1;

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"  message:notification.alertBody delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        application.applicationIconBadgeNumber -= 1;
    }
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    religiousMessages = [[NSArray alloc] initWithObjects:@"Genesis 9:20-26 - Noah became drunk; the result was immorality and family trouble.", @"Genesis 19:30-38 - Lot was so drunk he did not know what he was doing; this led to immorality", @"Leviticus 10:9-11 - God commanded priests not to drink so that they could tell the difference between the holy and the unholy.",@"Deuteronomy 32:33 - Intoxicating wine is like the poison of serpents, the cruel venom of asps.",@"Proverbs 23:21 - Drunkenness causes poverty.",@"Proverbs 23:29-30 - Drinking causes woe, sorrow, fighting, babbling, wounds without cause and red eyes.",@"Proverbs 23:33 - Alcohol causes the drinker to have strange and adulterous thoughts, produces willfulness, and prevents reformation.",@" Isaiah 5:11-12 - Woe to those who get up early to drink and stay up late at night to get drunk.",@"1 Peter 4:3-4 - The past life of drunkenness and carousing has no place in the Christian’s life.",@"Titus 2:2-3 - The older men and older women of the church are to be temperate and not addicted to wine.",@"1 Thessalonians 5:6-7 - Christians are to be alert and self-controlled, belonging to the day. Drunkards belong to the night and darkness.",@"Ephesians 5:18 - In contrast to being drunk with wine, the believer is to be filled with the Spirit.",@"Luke 21:34 - Drunkenness will cause a person not to be ready for the Lord’s return.",nil];
    funnyMessages = [[NSArray alloc] initWithObjects:@"Being a little bit alcoholic is like being a little bit pregnant.", @"Change: Everything after but is BS.", @"Denial ain't just a river in Egypt.", @"If you want to see who the drunk is, look for who's shouting for the manager.", @"If you pray for honesty, the chances of your lying go 'way up.", @"Knowing why is the booby prize of life.", @"Don't get too Hungry, Angry, Lonely or Tired (H.A.L.T.)", @"Meetings: AA is like a raffle; you must be present to win.", @"Life sucks! (but in AA, life sucks one day at a time).", @"Pain: If your ass falls off, put it in a wheelbarrow and take it to a meeting.", @"When I ask for patience, God gives me a traffic jam.", @"If you are having trouble getting on your knees to pray in the morning, put your shoes under the middle of the bed the night before.", nil];
    inspirationalMessages = [[NSArray alloc] initWithObjects:@"Being humble means being teachable.", @"God grant me the serenity to accept the things I cannot change, the courage to change the things I can, and the wisdom to know the difference.", @"Comfort: The willingness to be uncomfortable leads to being comfortable.", @"The person takes a drink, the drink takes a drink, the drink takes the person.", @"Everything is all right.", @"F.E.A.R. doesn't have to mean Forget Everything And Run.", @"Faith can't be taught; it can only be caught.", @"Failure isn't fatal; success isn't permanent.", @"The person who forgets is doomed to repeat.", @"Forgiveness: The number one way to relieve pain is to forgive.", @"Today is a gift; that's why it's called the present.", @"Grateful alcoholics don't drink, and drinking alcoholics aren't grateful.", @"Growth: It's not so important why you are an alcoholic-but rather what are you going to do about it?", @"H.A.L.T.: Happy, Appreciative, Lovable, Teachable.", @"If you are not happy with what you have, what makes you think you would be happy with more?", @"Insanity is doing the same thing over and over again, and expecting different results.", @"Don't get too Hungry, Angry, Lonely or Tired (H.A.L.T.)", nil];
    
    //If object has not been created, create it.
    if(self.locationManager==nil){
        _locationManager=[[CLLocationManager alloc] init];
        //I'm using ARC with this project so no need to release
        
        _locationManager.delegate=self;
        
        //The desired accuracy that you want, not guaranteed though
        _locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        
        self.locationManager=_locationManager;
    }
    
    if(self.userSettings == nil) {
        _userSettings = [[XYZUserSettings alloc] init];
        self.userSettings=_userSettings;
        
    }
    
    UILocalNotification *locationNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    if (locationNotification) {
        // Set icon badge number to zero
        application.applicationIconBadgeNumber = 0;
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
    application.applicationIconBadgeNumber = 0;
    [self.locationManager stopMonitoringSignificantLocationChanges];
    
}

@end
