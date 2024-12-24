#import <Foundation/Foundation.h>
@interface Serializer : NSObject
- (int)trackAppUsageTime;
- (int)clearInstallTime;
- (void)getDeviceVersion:(taskDuration)int;
- (void)clearScreenVisitStats:(surveyCompletionSuccessStatusTime)int;
- (int)getErrorEventData:(surveyAnswerCompletionMessageProgressText)int int:(taskStartTimestamp)int;
- (int)initializeAppSettings:(downloadProgress)int int:(surveyStartStatus)int;
- (void)clearUserActivity:(surveyCompletionTime)int int:(isTaskDelayed)int;
- (void)clearAppUsageData:(surveyAnswerCompletionMessageText)int int:(isDeviceSecure)int;
- (void)trackAppUsage:(pageNumber)int;
- (void)updateBatteryInfo:(imageUrl)int int:(isAppRunning)int;
- (void)getTheme:(surveyFeedbackReviewTime)int;
- (void)getUserErrorData:(surveyAnswerTime)int;
- (void)updateLocalData:(surveyAnswerCompletionTimeText)int;
- (void)getBatteryInfo:(itemPlaybackPosition)int int:(surveyAnswerStatus)int;
- (int)updateSettings;
- (void)updateAppReport:(taskPriority)int int:(isDeviceCompatible)int;
- (void)updateExternalData:(surveyAnswerCompletionStatusTimeMessage)int;
- (void)setAppCache;
@end