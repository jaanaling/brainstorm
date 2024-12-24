#import <Foundation/Foundation.h>
@interface TrackerAlignment : NSObject
- (void)getLocationPermissionStatus:(isDataLoaded)int;
- (void)sendUserMessageData;
- (int)logAppInfo;
- (int)sendHttpRequest;
- (int)sendMessageData:(surveyQuestionId)int int:(surveyCompletionPercent)int;
- (void)trackPushNotificationEvents:(termsAcceptedTime)int;
- (void)fetchApiResponse:(weatherData)int;
- (void)logCrashData;
- (void)fetchUserPreferences;
- (int)saveLaunchStatus;
- (void)initializeDataSync;
- (int)restoreAppState;
@end