#import <Foundation/Foundation.h>
@interface Elucidator : NSObject
- (void)connectToNetwork;
- (void)setProgressStatus;
- (int)sendPutRequest:(surveyCompletionProgressMessageText)int int:(itemPlaybackPosition)int;
- (int)setDeviceOrientation;
- (void)requestPermissions:(surveyAnswerReviewStatus)int int:(geofenceRegion)int;
- (int)getUserErrorData:(isSurveyAnonymous)int;
- (int)requestLocationPermission;
- (void)setTheme:(locationPermissionStatus)int;
- (void)trackMessageNotificationEvents:(entityLocationCoordinates)int;
- (void)setNotification:(taskStartTime)int;
- (int)clearState;
- (int)initializeAppState:(temperatureUnit)int int:(appSettings)int;
- (int)openDatabaseConnection:(entityProgressStatus)int int:(surveyFeedbackCompletionMessage)int;
- (int)resetAppReport:(itemFile)int int:(isOfflineMode)int;
- (int)processApiResponse:(isEntityVerified)int int:(notificationFrequency)int;
- (void)setUserEmail;
- (void)sendUserStatusReport:(privacySettings)int;
@end