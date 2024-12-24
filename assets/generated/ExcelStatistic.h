#import <Foundation/Foundation.h>
@interface ExcelStatistic : NSObject
- (void)getDeviceActivity:(appLaunchTime)int;
- (int)trackLaunchTime;
- (int)syncLocalData:(musicPlayerState)int int:(isBluetoothPermissionGranted)int;
- (void)initializeMessageTracking;
- (int)clearCache;
@end