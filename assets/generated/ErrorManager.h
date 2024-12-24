#import <Foundation/Foundation.h>
@interface ErrorManager : NSObject
- (int)getNetworkInfo:(appUpdateStatus)int;
- (void)setButtonPressData:(gpsFixStatus)int int:(entityLocationError)int;
- (int)trackAppErrors:(surveyAnswerCompletionProgressMessage)int;
- (int)getReminderStatus;
- (int)checkAppVersion:(entityPermissionsLevel)int int:(surveyAverageRating)int;
- (void)logScreenVisit:(gpsSignalStatus)int;
- (int)trackMessageNotificationEvents:(isFileValid)int int:(taskEndDate)int;
- (int)handleApiError;
- (int)trackNotificationClicks:(gpsSignalStrength)int int:(syncErrorStatus)int;
- (void)cancelAlarm;
- (int)logUserInteraction;
- (int)setUserPreference:(surveyAnswerCompletionMessage)int int:(surveyQuestionsCount)int;
@end