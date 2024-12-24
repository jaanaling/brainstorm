#import <Foundation/Foundation.h>
@interface Badge : NSObject
- (int)setAppState:(isAppInNightMode)int int:(appStateChange)int;
- (void)scheduleNotification;
- (void)getUserLocation:(surveyStatusMessage)int int:(themePreference)int;
- (int)setSystemErrorData:(surveyAnswerReviewCompletionTimeText)int;
- (int)logActivityEvent:(surveyResponseStatus)int int:(appInMemoryUsage)int;
- (void)checkScreenVisitStats;
- (int)displayLoadingIndicator:(mediaPlayerState)int;
- (void)clearAppErrorData;
- (int)saveToDatabase;
- (int)logAppUsage;
- (int)restartApp:(networkSpeed)int;
- (int)trackUserErrors;
- (int)getActivityReport:(isAppUpToDate)int;
- (int)sendAppMetrics:(isDataSyncResumed)int;
- (int)syncUserData:(appVersion)int;
- (void)revokePermission;
- (void)sendEmail:(isTaskInProgress)int int:(isRecordingInProgress)int;
@end