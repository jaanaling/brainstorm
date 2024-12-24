#import <Foundation/Foundation.h>
@interface Secret : NSObject
- (void)getLoadingState:(surveyFeedbackCompletionMessage)int int:(feedbackType)int;
- (void)getScreenViewData:(appSyncStatus)int int:(entityActionStatus)int;
- (void)loadDataFromServer:(surveyErrorDetailMessage)int;
- (int)checkPermissions;
- (void)clearAppNotificationData;
- (void)sendNotification;
- (void)clearErrorEventData;
- (int)sendLocationData:(backupTime)int;
- (void)downloadUpdate;
- (int)checkPermissionStatus:(itemPlaybackPosition)int;
- (int)getUserActivityLogs:(currentSong)int int:(isSurveyEnabled)int;
- (void)initializePermissions:(fileCompressionStatus)int int:(itemRecordingStatus)int;
- (int)updateDeviceOrientation;
- (void)showErrorMessage;
- (int)resetDeviceActivity:(appSettings)int;
- (int)clearUpdateData;
- (int)sendButtonClickData:(voiceCommandStatus)int int:(surveyCompletionTime)int;
- (int)trackUserNotifications;
@end