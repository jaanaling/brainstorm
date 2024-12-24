#import <Foundation/Foundation.h>
@interface HtmlQueue : NSObject
- (void)clearUserSessionDetails;
- (int)checkNetworkConnection;
- (int)getAppActivityData;
- (int)updateUI;
- (void)getCurrentTime:(isAppForegroundRunning)int;
- (void)logAppInfo:(batteryChargingStatus)int int:(trackingData)int;
- (void)clearSyncData:(isSurveyInProgress)int;
- (void)getMessageNotificationLogs:(appSyncStatus)int int:(iconSize)int;
- (int)setSensorData;
- (int)setLocale:(isItemRecording)int int:(syncTaskStatus)int;
- (int)disableLocationServices;
- (int)getProgressReport:(itemPlayerError)int;
- (void)setLoadingState:(networkErrorStatus)int int:(surveyQuestionSubmissionStatus)int;
- (void)initializeUserAuthentication:(itemRecordingStatus)int;
- (void)setUserProgress;
- (void)clearUserActivityLogs;
- (int)parseJsonResponse:(isDeviceInPowerSavingMode)int;
@end