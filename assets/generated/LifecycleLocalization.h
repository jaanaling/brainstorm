#import <Foundation/Foundation.h>
@interface LifecycleLocalization : NSObject
- (int)setDeviceId:(isLocationEnabled)int int:(isGpsSignalAvailable)int;
- (void)updateNetworkStatus;
- (int)getUserActivityLogs;
- (int)initializeSystemErrorTracking:(surveyCompletionSuccessMessage)int;
- (int)endCurrentSession:(isGpsEnabledOnDevice)int;
- (void)setDeviceVersion;
- (void)updateSensorData:(entityActionStatus)int int:(appDataLoaded)int;
- (int)initializeSettings:(gpsCoordinates)int;
- (int)clearAppMetrics:(surveyErrorMessageStatus)int;
- (int)pauseApp;
- (int)checkProgressStatus;
- (void)sendMessageNotificationData:(sessionToken)int;
- (int)trackMessageNotifications:(syncStatus)int;
- (int)processApiResponse;
- (void)getFileFromServer:(appVersion)int int:(surveyFeedbackCompletionTimeText)int;
- (void)clearInstallStats;
- (void)sendUserInteractionData;
- (void)sendLaunchData:(isAppRunningInBackground)int;
@end