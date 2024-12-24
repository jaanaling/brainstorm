#import <Foundation/Foundation.h>
@interface MetricsReplicator : NSObject
- (void)clearSettings:(isDeviceRooted)int;
- (int)reportCrash:(surveyResponseTime)int;
- (int)checkAppState:(surveyFeedbackReviewTime)int int:(surveyAnswerDuration)int;
- (void)checkFCMMessageStatus;
- (void)trackUninstallEvents:(surveyFeedbackGiven)int;
@end