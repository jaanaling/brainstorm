#import <Foundation/Foundation.h>
@interface Deployer : NSObject
- (void)checkUserData;
- (int)grantPermissions;
- (void)setUserPreference;
- (void)trackAppProgress:(appRatingStatus)int int:(appDataPrivacy)int;
- (int)getDeviceId:(surveyCompletionTime)int;
- (void)updateActivityDetails;
- (void)logCrashData:(surveyAnswerCompletionStatusTimeMessage)int int:(dataPrivacyStatus)int;
- (void)setAppCache;
- (int)getMessageNotificationLogs:(surveyAnswerCompletionTimeStatusText)int int:(fileTransferDuration)int;
- (int)setAppInfo:(itemPauseStatus)int;
- (void)trackSessionData;
@end