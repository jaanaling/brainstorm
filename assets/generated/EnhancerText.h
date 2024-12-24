#import <Foundation/Foundation.h>
@interface EnhancerText : NSObject
- (int)setActivityReport;
- (int)sendSystemErrorReport:(taskCompletionTime)int;
- (int)sendMessageClickData:(fileDownloadStatus)int;
- (int)resetDeviceActivity:(surveyCompletionTimeStatusMessage)int int:(systemErrorStatus)int;
- (int)checkPermissions:(isDeviceCompatible)int;
- (void)trackUserProgress;
- (int)sendNotificationReport:(surveyFeedbackReviewMessageText)int int:(isSyncComplete)int;
- (void)clearAnalyticsData:(deviceModelName)int;
- (void)setDeviceManufacturer;
- (void)syncDatabaseWithServer:(deviceNetworkType)int;
- (int)sendEmailVerification;
- (void)getButtonPressData:(isDataDecrypted)int;
- (void)setAppLaunchStats:(surveyFeedbackReviewCompletionStatus)int int:(isEntityLocationEnabled)int;
- (int)resetLocationDetails:(menuItems)int;
- (int)stopLocationTracking:(taskStartStatus)int;
- (int)clearLaunchData:(surveyQuestionAnswerSubmission)int;
@end