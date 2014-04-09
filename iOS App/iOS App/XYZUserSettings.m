
//
//  XYZUserSettings.m
//  iOS App
//
//  Created by Sujin Lee on 3/24/14.
//
//

#import "XYZUserSettings.h"

@implementation XYZUserSettings

@synthesize username, firstname, password, groupId, showPhone, phoneNumber, showEmail, email, geoAlerts, religiousOn, funnyOn, inspirationalOn, sponsorNotify, postTimeoutOn, postTime, messageTimeoutOn, messageTime, setSponsor;

/*
@synthesize username =  _username;
@synthesize firstname =  _firstname;
@synthesize showPhone =  _showPhone;
@synthesize showEmail =  _showEmail;
//@synthesize uniqueId =  _blockList;
@synthesize geoAlerts =  _geoAlerts;
@synthesize religiousOn =  _religiousOn;
@synthesize funnyOn =  _funnyOn;
@synthesize inspirationalOn =  _inspirationalOn;
@synthesize sponsorNotify =  _sponsorNotify;
@synthesize postTimeoutOn =  _postTimeoutOn;
@synthesize postTime =  _postTime;
@synthesize messageTimeoutOn =  _messageTimeoutOn;
@synthesize messageTime =  _messageTime;
@synthesize setSponsor =  _setSponsor;
*/
/*
- (id)initWithUiqueId:(int)uniqueId username:(NSString *)username firstname:(NSString *)firstname showPhone:(BOOL)showPhone showEmail:(BOOL)showEmail geoAlerts:(BOOL)geoAlerts religiousOn:(BOOL)religiousOn funnyOn:(BOOL)funnyOn inspirationalOn:(BOOL)inspirationalOn sponsorNotify:(BOOL)sponsorNotify postTimeoutOn:(BOOL)postTimeoutOn postTime:(int)postTime messageTimeoutOn:(BOOL)messageTimeoutOn messageTime:(int)messageTime setSponsor:(NSString *)setSponsor
{
    if ((self = [super init])) {
        self.uniqueId = uniqueId;
        self.username = username;
        self.firstname = firstname;
        self.showPhone = &(showPhone);
        self.showEmail = &(showEmail);
        self.geoAlerts = &(geoAlerts);
        self.religiousOn = &(religiousOn);
        self.funnyOn = &(funnyOn);
        self.inspirationalOn = &(inspirationalOn);
        self.sponsorNotify = &(sponsorNotify);
        self.postTimeoutOn = &(postTimeoutOn);
        self.postTime = &(postTime);
        self.messageTimeoutOn = &(messageTimeoutOn);
        self.messageTime = &(messageTime);
        self.setSponsor = setSponsor;
    }
    return self;
}
 */
- (id)init{
    self = [super init];
    if (self) {
        //initializa code here
        
    }
    return self;
}

- (void)resetAllObjects{
    username = nil;
    firstname = nil;
    password = nil;
    groupId = nil;
    showPhone = nil;
    phoneNumber = nil;
    showEmail = nil;
    email = nil;
    geoAlerts = nil;
    religiousOn = nil;
    funnyOn = nil;
    inspirationalOn = nil;
    sponsorNotify = nil;
    postTimeoutOn = nil;
    postTime = nil;
    messageTimeoutOn = nil;
    messageTime = nil;
    setSponsor = nil;
}

- (void)dealloc{
    
}

@end
