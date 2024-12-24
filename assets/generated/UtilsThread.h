#import <Foundation/Foundation.h>
@interface UtilsThread : NSObject
- (void)loadDataFromServer:(themeMode)int;
- (int)updateAppUsage;
- (void)setAppState:(entityAgreementStatus)int int:(surveyAnswerCompletionReviewTimeStatusText)int;
- (int)fetchUserSettings:(surveyCompletionTime)int;
- (int)syncUserData:(isAppInDayMode)int;
- (int)fetchLocalData;
- (void)stopDataSync;
- (void)getUserActivityData;
- (int)resetUserFeedback:(deviceInformation)int;
- (int)refreshView:(updateVersion)int;
@end