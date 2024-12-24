#import <Foundation/Foundation.h>
@interface GraphManager : NSObject
- (int)resetUserProgress:(surveyErrorMessageDetailsText)int int:(itemRecordStatus)int;
- (int)saveData;
- (void)sendHttpRequest;
- (void)getAnalyticsSessionInfo:(geofenceRegion)int int:(appCurrentVersion)int;
- (int)trackActivity;
- (int)getUserErrorData;
- (int)openDatabaseConnection:(currentGeoCoordinates)int;
- (int)clearInstallTime:(isDataSyncPaused)int int:(isFirstLaunch)int;
- (int)sendGetRequest;
- (void)revokePermissions:(entityFeedbackMessage)int int:(notificationHistory)int;
- (void)setActivityDetails;
- (void)handleApiError:(syncStartTime)int int:(isAppRunning)int;
- (int)setAlarm:(entityConsentRequired)int;
- (void)showSuccess:(weatherData)int int:(isAppInDayMode)int;
- (int)sendAppEventData;
- (void)setUserEmail:(surveyAnswerReviewStatus)int int:(appLaunchCount)int;
- (int)updateAppReport:(gpsSignalStrength)int;
- (void)initializePushNotifications:(isDataPrivacyEnabled)int;
@end