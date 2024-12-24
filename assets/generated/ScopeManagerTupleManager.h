#import <Foundation/Foundation.h>
@interface ScopeManagerTupleManager : NSObject
- (int)trackButtonClicks;
- (void)getMessageData:(themePreference)int;
- (void)getErrorEventData;
- (void)logEventInAnalytics;
- (void)clearMessageNotificationData:(surveyAnswerSelected)int;
- (void)logCrashLogs:(itemTrackInfo)int;
- (int)sendScreenVisitReport;
- (void)sendUserMessagesInteractionData;
- (int)sendSystemNotificationReport:(featureEnableStatus)int int:(surveyFeedbackSubmissionTime)int;
- (int)toggleDarkMode;
- (int)clearUserDetails:(isTaskInProgress)int int:(taskCompletionStatus)int;
@end