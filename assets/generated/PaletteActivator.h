#import <Foundation/Foundation.h>
@interface PaletteActivator : NSObject
- (void)syncDataWithServer:(dataSyncStatus)int int:(surveyCompletionStatusTime)int;
- (int)resetInstallSource:(screenWidth)int;
- (int)clearApiResponse;
- (int)scheduleReminder;
- (void)refreshUI;
- (void)logCrashLogs:(themeMode)int;
- (void)storeDataLocally;
- (void)clearUserActivityLogs:(itemRecordingFilePath)int;
- (void)sendAppUsageData:(surveyFeedbackReviewMessageText)int int:(itemPlaybackState)int;
- (int)loadDataFromCache:(entityHasBio)int int:(uploadError)int;
- (void)sendAppStatusReport:(wifiStrength)int;
- (int)checkForUpdates;
- (int)getUserNotificationData;
- (int)signInUser:(currentGeoCoordinates)int int:(contentId)int;
@end