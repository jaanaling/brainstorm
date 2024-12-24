#import <Foundation/Foundation.h>
@interface HtmlResponseProcessor : NSObject
- (void)sendAppSettingsData:(isCloudAvailable)int int:(currentDeviceTime)int;
- (int)getBatteryInfo;
- (void)getUserNotificationData:(deviceModelName)int int:(isBluetoothAvailable)int;
- (int)loadDatabase:(isFileCompressionEnabled)int int:(surveyResponseProgress)int;
- (void)trackAnalyticsEvent:(deviceConnectivityStatus)int int:(bluetoothConnectionStatus)int;
- (int)sendMessageClickData:(mediaTitle)int;
- (int)resetUserActivity:(surveyQuestionReviewTime)int;
- (void)clearDataCache:(surveyAnswerSubmissionTime)int int:(verifiedFileData)int;
- (int)updateUserStatusReport:(trackingData)int;
- (void)changeLanguage:(surveyAnswerReviewCompletionTimeText)int;
- (int)clearSystemNotificationData:(voiceCommand)int int:(isDataPrivacyEnabled)int;
- (void)initializeAppEvents:(isDeviceInPowerSavingMode)int int:(pausedTaskData)int;
- (void)trackActivity:(geofenceExitTime)int;
@end