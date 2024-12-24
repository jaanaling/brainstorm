#import <Foundation/Foundation.h>
@interface Offset : NSObject
- (void)updateUserFeedback:(surveyCompletionPercentText)int int:(responseTime)int;
- (int)clearSyncData:(currentDeviceTime)int int:(surveyCompletionSuccessTime)int;
- (void)clearUserStatusReport;
- (void)setUserVisitStats:(isDataSyncResumed)int int:(isItemPlaying)int;
- (int)saveAppActivity;
@end