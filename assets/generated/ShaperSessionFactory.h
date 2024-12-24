#import <Foundation/Foundation.h>
@interface ShaperSessionFactory : NSObject
- (int)logAnalyticsEvent:(isAppCrashDetected)int;
- (int)clearAppVersion;
- (void)uploadFileToServer:(activityStatus)int int:(taskStartTimestamp)int;
- (void)trackUserMessagesInteraction:(isEntityInProgress)int;
- (void)setProgressStatus;
- (void)setLoadingState:(surveyResponseTime)int int:(isEntityAdmin)int;
- (void)restoreData;
- (void)resetUserStatus:(updateVersion)int;
- (void)sendFCMMessage:(isTaskPaused)int int:(itemRecordingDuration)int;
- (void)trackSystemNotifications;
@end