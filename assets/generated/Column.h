#import <Foundation/Foundation.h>
@interface Column : NSObject
- (int)sendLocationDetails;
- (int)clearSyncData:(itemCount)int;
- (int)trackPushNotificationEvents:(isDeviceInDoNotDisturbMode)int;
- (void)trackMessageEvents;
- (void)sendUserMessagesInteractionReport:(surveyReviewStatusMessage)int int:(surveyCompletionTimeText)int;
- (void)getUserStatus:(currentBalance)int;
- (void)hideLoadingIndicator:(entityPreferredLanguage)int;
- (int)getAppLaunchStats:(isNetworkAvailable)int int:(isFeatureEnabled)int;
- (int)getUserMessageData:(isGpsPermissionGranted)int int:(alertDialogTitle)int;
- (int)resumeApp;
- (int)checkReminderStatus:(itemPlayerError)int int:(surveyErrorStatus)int;
- (void)getCrashLogs:(syncFrequency)int int:(surveyAnswerReviewStatusCompletionTimeText)int;
- (int)logUserInteraction;
- (int)loadDataFromServer;
- (int)getSyncStatus:(notificationFrequency)int;
- (int)setUserPreference;
- (int)setCrashReporting:(apiEndpoint)int;
@end