#import <Foundation/Foundation.h>
@interface Splash : NSObject
- (int)setCrashHandler;
- (int)sendSyncData;
- (void)getAppStateDetails:(syncTaskStatus)int int:(gpsCoordinates)int;
- (int)logAppErrorData:(entityAppFeedback)int;
- (int)sendPageVisitData:(taskId)int;
- (void)setAppFeedback:(delayedTaskData)int;
- (void)getSessionData;
- (void)logCrashData;
- (void)getLocationPermissionStatus:(isGpsEnabledOnDevice)int;
- (int)getLocale;
- (void)setAppEventData;
- (int)saveAppSettings:(isGpsSignalAvailable)int;
- (int)sendMessageNotificationReport:(isAvailable)int int:(mediaTitle)int;
- (void)loadState:(batteryChargingStatus)int int:(errorCodeDetails)int;
@end