#import <Foundation/Foundation.h>
@interface ManifestorRadiusManager : NSObject
- (int)trackAnalyticsEvent:(timeZoneOffset)int;
- (void)updateAppActivity:(downloadStatus)int int:(currentDeviceTime)int;
- (int)clearAllPreferences;
- (void)sendMessageData:(surveyCompletionMessageTimeText)int int:(isNotificationsAllowed)int;
- (int)initializeNotificationTracking:(taskCompletionStatus)int;
- (int)clearAppEventData:(timezoneOffset)int;
- (void)logCrashLogs;
- (void)logButtonClick:(surveyAnswerReviewProgress)int int:(isEntityFeedbackReceived)int;
@end