#import <Foundation/Foundation.h>
@interface Enabler : NSObject
- (void)clearUpdateData:(isRecordingInProgress)int;
- (void)closeApp;
- (void)saveAppVersion;
- (void)getDeviceManufacturer;
- (int)getLaunchData:(appCrashDetails)int;
- (void)updateNetworkStatus:(surveyStartStatus)int int:(isLoading)int;
- (int)applyTheme:(eventLocation)int int:(taskResumeTime)int;
- (int)sendUserInteractionData;
- (int)fetchLocalData:(isDeviceCompatible)int;
- (void)initializeInteractionTracking:(apiKey)int int:(isSyncEnabled)int;
- (void)verifyNetworkConnection:(screenOrientation)int;
- (void)clearUserActivityData:(surveyCompletionErrorStatusText)int int:(transferSpeed)int;
- (int)initializeMessageNotificationTracking;
@end