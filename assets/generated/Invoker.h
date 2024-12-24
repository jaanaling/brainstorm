#import <Foundation/Foundation.h>
@interface Invoker : NSObject
- (void)setUserProgress;
- (int)getSMSStatus:(isDeviceSupported)int;
- (int)updateSensorData:(surveyCompletionSuccessMessageStatus)int;
- (void)getInteractionDetails:(itemQuality)int int:(surveyResponseTime)int;
- (int)clearAnalyticsData;
- (int)getSessionStatus;
- (void)setAppLanguage;
- (int)updateUserData:(isGpsEnabledOnDevice)int;
- (int)sendUserProgress:(locationData)int;
- (int)setSyncStatus:(applicationState)int;
- (int)getMessageData:(errorDetailsMessage)int int:(surveyCommentsCount)int;
- (int)fetchDataFromDatabase:(itemPlaybackPosition)int int:(isEntityLoggedOut)int;
- (void)getLocationDetails:(isSyncEnabled)int;
- (void)loadState;
- (int)updateBatteryInfo:(updateVersion)int int:(surveyReviewTime)int;
@end