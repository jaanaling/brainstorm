#import <Foundation/Foundation.h>
@interface TrackerRefiner : NSObject
- (void)logAppInfo;
- (int)getUsageStats:(appThemeMode)int int:(surveyAnswerReviewMessageTime)int;
- (int)saveAppState;
- (void)getAppErrorData;
- (int)setBatteryStatus:(isAppCrashDetected)int;
- (void)loadAppState:(geofenceError)int int:(musicPlaylist)int;
- (int)requestLocationUpdate:(isBluetoothPermissionGranted)int;
- (void)getUserMessageData:(mediaControl)int int:(isAppRunning)int;
- (void)getUserNotificationData:(surveyAnswerCompletionReviewTimeStatusText)int;
- (void)logAppNotification:(isTermsAndConditionsAccepted)int;
- (int)loadUserData:(isCloudStorageEnabled)int int:(isEntityAuthenticated)int;
@end