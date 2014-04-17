//
//  XYZUserSettings.h
//  iOS App
//
//  Created by Sujin Lee on 3/24/14.
//
//

#import <Foundation/Foundation.h>

@interface XYZUserSettings : NSObject{
    NSString *_username;
    NSString *_firstname;
    NSString *_password;
    int *_groupId;
    NSString *_showPhone;
    NSString *_phoneNumber;
    BOOL *_showEmail;
    NSString *_email;
    //NSArray *_blockList;
    BOOL *_geoAlerts;
    BOOL *_religiousOn;
    BOOL *_funnyOn;
    BOOL *_inspirationalOn;
    BOOL *_sponsorNotify;
    BOOL *_postTimeoutOn;
    int *_postTime;
    BOOL *_messageTimeoutOn;
    int *_messageTime;
    NSString *_setSponsor;

}
-(void)resetAllObjects;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *firstname;
@property (nonatomic, copy) NSString *password;
@property int *groupId;
@property (nonatomic, copy) NSString *showPhone;
@property (nonatomic, copy) NSString *phoneNumber;
@property BOOL *showEmail;
@property (nonatomic, copy) NSString *email;
//@property (nonatomic, copy) NSArray *blockList;
@property BOOL *geoAlerts;
@property BOOL *religiousOn;
@property BOOL *funnyOn;
@property BOOL *inspirationalOn;
@property BOOL *sponsorNotify;
@property BOOL *postTimeoutOn;
@property int *postTime;
@property BOOL *messageTimeoutOn;
@property int *messageTime;
@property (nonatomic, copy) NSString *setSponsor;
/*
- (id)initWithUiqueId:(int)uniqueId username:(NSString *)username firstname:(NSString *)firstname showPhone:(BOOL)showPhone showEmail:(BOOL)showEmail geoAlerts:(BOOL)geoAlerts religiousOn:(BOOL)religiousOn funnyOn:(BOOL)funnyOn inspirationalOn:(BOOL)inspirationalOn sponsorNotify:(BOOL)sponsorNotify postTimeoutOn:(BOOL)postTimeoutOn postTime:(int)postTime messageTimeoutOn:(BOOL)messageTimeoutOn messageTime:(int)messageTime setSponsor:(NSString *)setSponsor;
*/
@end
