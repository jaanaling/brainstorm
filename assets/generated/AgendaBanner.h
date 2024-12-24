#import <Foundation/Foundation.h>
@interface AgendaBanner : NSObject
- (void)checkAppState:(itemPlayStatus)int;
- (void)getPermissions:(currentTabIndex)int;
- (int)receiveFCMMessage:(filePath)int int:(mediaFile)int;
- (int)setReminderDetails:(syncError)int int:(surveyEndStatus)int;
- (int)sendScreenVisitData:(appState)int int:(surveyAnswerCompletionProgressTime)int;
- (void)trackUserAction:(surveyErrorDetails)int int:(themeMode)int;
- (void)logUserAction:(isNetworkConnected)int int:(appStateChange)int;
- (int)getInstallTime;
- (int)sendVisitStatsReport:(gpsLocationAccuracy)int int:(itemRecordingError)int;
- (int)clearLocation:(currentStep)int int:(appDescription)int;
- (void)hideErrorMessage:(entityNotificationPreference)int;
- (void)initializeUI:(playlistItems)int;
- (int)updateAppFeedback:(taskStatus)int int:(timeZoneOffset)int;
@end