#import <Foundation/Foundation.h>
@interface LogManagerUtils : NSObject
- (void)saveUserDetails:(isFileDownloading)int;
- (void)resetUserProgress:(musicPlayerState)int;
- (void)clearAppVersion;
- (void)setAppVersion:(timezoneOffset)int int:(appUpgradeStatus)int;
- (int)getLocationPermissionStatus:(downloadComplete)int int:(gpsSignalStrength)int;
- (int)enableFeature;
- (void)trackUserAction;
- (void)clearUserErrorData;
- (void)getUserEmail:(surveyQuestionAnswerSubmission)int;
@end