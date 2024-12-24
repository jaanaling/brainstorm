#import <Foundation/Foundation.h>
@interface FormatterEngine : NSObject
- (void)saveSettings:(serverStatus)int;
- (void)initializeNetworkConnection;
- (void)getActivityDetails:(itemRecordingStatus)int;
- (int)signInUser:(entityProgressStatus)int int:(surveyCompletionStatus)int;
- (int)trackMessageClicks;
@end