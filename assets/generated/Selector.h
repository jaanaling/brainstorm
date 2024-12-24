#import <Foundation/Foundation.h>
@interface Selector : NSObject
- (int)sendActivityDetails;
- (void)trackError:(lastActionTimestamp)int int:(surveyFeedbackReceived)int;
- (int)logScreenView:(isDeviceSecure)int int:(appDataPrivacy)int;
- (void)savePreference;
- (int)loadInitialData;
- (void)checkAppCache;
- (int)setUserMessagesInteractionData;
- (int)sendUserMessagesInteractionReport:(isAvailable)int int:(isDataSynced)int;
- (int)sendInteractionData:(sessionToken)int;
- (int)clearAppErrorData:(surveyFeedbackSubmissionTime)int;
- (int)clearUserErrorData;
- (void)resetBatteryInfo:(filePath)int;
@end