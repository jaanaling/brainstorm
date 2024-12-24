#import <Foundation/Foundation.h>
@interface ReparserWindow : NSObject
- (int)logScreenVisit:(messageCount)int;
- (int)trackEvent:(activityStatus)int int:(privacySettings)int;
- (void)getUserSessionDetails:(surveyCompletionSuccessMessage)int;
- (void)clearUserPreferences;
- (void)unsubscribeFromPushNotifications;
- (int)checkLocation:(entityLocationSpeed)int;
- (void)setAppErrorData:(isGeofenceEnabled)int int:(isEntityAdmin)int;
- (int)initializeUserErrorTracking;
- (void)getAppLaunchStats;
- (void)setPushNotificationData;
- (void)setButtonPressData;
- (int)saveLaunchStatus;
- (int)fetchAppVersion:(isTutorialCompleted)int;
- (int)sendMessageNotificationLogs:(surveyAnswerSubmissionTime)int int:(surveyErrorMessageDetailsText)int;
- (void)setUserPreference:(activityLog)int int:(pageNumber)int;
- (int)getActivityLog:(surveyCompletionErrorStatus)int int:(isDarkMode)int;
@end