#import <Foundation/Foundation.h>
@interface Socket : NSObject
- (int)sendCrashlyticsData:(isNotificationsEnabled)int;
- (int)sendEventToAnalytics:(wifiStrength)int int:(isVerified)int;
- (int)grantPermission;
- (void)clearInstallTime:(isFeatureEnabled)int int:(surveyQuestionType)int;
- (void)checkSMSStatus:(dateFormat)int int:(surveyCompletionPercentText)int;
- (int)updateContent:(apiStatus)int int:(surveyRating)int;
- (int)setAppInfo;
@end