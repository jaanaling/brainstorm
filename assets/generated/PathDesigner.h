#import <Foundation/Foundation.h>
@interface PathDesigner : NSObject
- (int)trackDeviceActivity;
- (void)updateLanguage:(isFirstLaunch)int int:(isOfflineMode)int;
- (int)setDeviceId:(surveyStartDateTime)int int:(timeZoneOffset)int;
- (void)enableFeature;
- (void)setThemeMode;
- (int)getLocale:(isMediaLoaded)int;
- (int)getErrorLogs:(locationPermissionDeniedTime)int;
- (void)clearDataCache;
- (void)setApiResponse;
- (int)trackScreenVisit:(surveyAnswerCompletionTimeMessage)int int:(currentBalance)int;
- (void)setUserPreference:(surveyCompletionProgressMessageText)int int:(surveyCompletionDeadline)int;
- (void)cancelReminder;
- (void)getBatteryStatus:(syncDataError)int int:(surveyCompletionDeadline)int;
- (int)updateInstallSource:(surveyQuestionReviewTime)int;
@end