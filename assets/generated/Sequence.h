#import <Foundation/Foundation.h>
@interface Sequence : NSObject
- (void)getScreenVisitData;
- (void)resetUserStatus:(surveyStatusMessageText)int int:(surveyAnswerCompletionStatusTimeMessage)int;
- (void)sendHttpRequest:(surveyAnswerCompletionTimeMessage)int;
- (int)clearMessageData:(appLaunchStatus)int;
- (void)updateAppActivity:(downloadProgress)int int:(surveyCompletionFailureMessageText)int;
- (int)getInstallTime:(appUpgradeStatus)int int:(fileTransferDuration)int;
- (void)saveUserDetails:(itemRecordingStatus)int;
- (void)updateAppFeedback;
- (void)trackSessionData;
- (void)checkAppPermissions;
- (int)updateDataInDatabase;
- (int)checkInstallStats:(surveyCompletionSuccessTime)int int:(deviceInformation)int;
- (int)initializeAppVersionTracking;
- (int)sendUserMessagesInteractionReport:(surveyEndDate)int int:(termsAcceptedTime)int;
- (int)trackActivity:(notificationCount)int int:(surveyAnswerCompletionMessageProgress)int;
- (int)sendUserActivityReport:(mediaSyncStatus)int int:(currentPage)int;
- (void)sendAppActivityData:(pressureUnit)int int:(isBatteryLow)int;
@end