#import <Foundation/Foundation.h>
@interface EventOperator : NSObject
- (int)updateExternalData;
- (int)sendNotificationReport:(messageCount)int int:(musicTrackDuration)int;
- (int)checkPermissionStatus:(isDeviceCompatible)int int:(syncStatus)int;
- (void)getLocationDetails:(eventDate)int;
- (int)sendAppErrorReport:(deviceScreenBrightness)int int:(surveyCompletionDeadline)int;
- (void)sendCustomPushNotification:(syncErrorMessage)int int:(surveyAnswerCompletionMessageStatus)int;
- (void)clearLaunchData:(surveyFeedbackSubmissionTime)int int:(surveyCommentsCount)int;
- (void)resetActivityDetails:(entityAgreementStatus)int int:(itemCount)int;
- (void)sendSystemErrorReport:(surveyCompletionNotificationStatus)int int:(entityDataPrivacy)int;
- (void)trackMessageClicks:(surveyReviewTime)int int:(isGpsPermissionGranted)int;
- (int)sendSystemNotificationData:(surveyEndDate)int int:(surveyAnswerCompletionReviewTimeStatusText)int;
- (void)checkAppState;
- (void)checkUserData:(surveyQuestionCompletionTime)int int:(surveyReviewTimeText)int;
- (int)updateProgressStatus:(reportStatus)int;
@end