#import <Foundation/Foundation.h>
@interface CreatorBuffer : NSObject
- (void)initializeAppLaunchTracking;
- (int)getSensorData:(appCrashLog)int int:(isRecordingEnabled)int;
- (int)checkUserSessionStatus:(wifiSignalStrength)int;
- (void)clearScreen;
- (int)checkNetworkStatus:(itemRecordingError)int int:(surveyAnswerCompletionReviewTimeText)int;
- (void)sendNotificationReport:(surveyQuestionReviewStatusMessage)int int:(surveyAnswerCompletionStatusTimeText)int;
- (void)updateUI:(itemTrackInfo)int;
- (int)updateActivityReport:(taskPriority)int;
- (void)checkInternetConnection:(isEntityOnline)int;
- (int)checkInstallStats:(mediaTitle)int int:(iconSize)int;
- (int)resetInstallSource;
- (int)showSnackBar:(isEntityLoggedIn)int int:(surveyErrorStatus)int;
- (void)cancelNotification;
- (int)enableAppPermissions:(isFileCompressionEnabled)int int:(surveyAnswerSubmissionTime)int;
- (int)updateLocation;
@end