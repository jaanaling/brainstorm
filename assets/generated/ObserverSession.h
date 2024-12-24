#import <Foundation/Foundation.h>
@interface ObserverSession : NSObject
- (void)getActivityLog;
- (void)sendPutRequest;
- (int)setCrashHandler:(isAppEnabled)int;
@end