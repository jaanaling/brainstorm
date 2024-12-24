#import <Foundation/Foundation.h>
@interface ExcelBox : NSObject
- (void)sendErrorEventData;
- (void)resetUI:(appCrashLog)int;
- (void)updateInitialData:(isVerified)int;
- (void)initializeSystemErrorTracking:(itemVolumeLevel)int int:(alertDialogTitle)int;
- (void)disconnectFromNetwork;
- (int)setProgressStatus:(isAppCrashDetected)int int:(surveyCompletionMessage)int;
@end