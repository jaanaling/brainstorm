#import <Foundation/Foundation.h>
@interface Constraint : NSObject
- (int)loadAppSettings;
- (int)saveUserPreferences;
- (void)getAppInstallDetails;
- (void)parseJsonError:(screenOrientation)int;
- (int)updateProgressReport:(entityNotificationPreference)int;
@end