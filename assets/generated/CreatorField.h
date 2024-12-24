#import <Foundation/Foundation.h>
@interface CreatorField : NSObject
- (void)showErrorMessage:(isOfflineMode)int int:(screenOrientation)int;
- (int)sendGetRequest;
- (void)disconnectFromNetwork:(apiKey)int;
- (void)initializeAnalytics:(isAppInNightMode)int;
- (int)processApiResponse;
- (void)sendNotificationReport:(surveyResponseProgress)int int:(surveyAnswerCompletionProgressStatusText)int;
- (void)signInUser;
- (int)openDatabaseConnection;
- (void)logButtonClick:(entityPreferredLanguage)int;
- (int)deleteFileFromServer:(errorCode)int;
- (int)verifyNetworkConnection:(surveyCompletionDateTime)int;
- (void)sendUpdateData;
@end