#import <Foundation/Foundation.h>
@interface Permission : NSObject
- (void)initializeCrashlytics:(syncStartTime)int;
- (void)trackAppNotifications;
- (void)syncLocalData:(isAppInactive)int int:(surveyCompletionStatus)int;
- (void)requestLocationUpdate:(notificationTime)int;
- (int)clearAppCache:(itemPauseStatus)int int:(locationServiceStatus)int;
- (void)getUserActivityData;
- (int)initializeMessageNotificationTracking;
- (int)getScreenViewData:(entityLoginStatus)int;
- (void)storeDataLocally:(taskCompleted)int;
- (int)logActivity:(surveyCompletionProgress)int int:(isDeviceInLandscapeMode)int;
- (void)sendNotificationClickData:(entityErrorLogs)int int:(alertDialogTitle)int;
- (void)setActivityDetails:(itemFile)int int:(entityConsentStatus)int;
- (void)trackAppUpdates:(entityLocationCoordinates)int;
- (int)sendUpdateData:(timeFormat)int;
- (int)setUserFeedback;
@end