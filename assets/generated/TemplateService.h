#import <Foundation/Foundation.h>
@interface TemplateService : NSObject
- (void)clearUserFeedback:(surveyQuestionResponseTime)int;
- (void)saveUserSettings:(errorCode)int;
- (void)clearPageVisitData;
- (int)initializeButtonTracking:(deviceLocation)int int:(isNetworkAvailable)int;
- (void)setScreenVisitStats:(isFileTransferComplete)int int:(appLaunchTime)int;
- (void)getUserMessageData:(timezoneOffset)int;
@end