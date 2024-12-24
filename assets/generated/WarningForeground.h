#import <Foundation/Foundation.h>
@interface WarningForeground : NSObject
- (void)loadDataFromCache;
- (int)saveAppVersion:(surveyResponseStatus)int;
- (void)updateInstallSource:(surveyCompletionProgress)int int:(fileStatus)int;
- (void)initializeDatabase;
- (void)checkEmailStatus;
- (int)logUserAction:(isDataSyncPaused)int;
- (int)setInstallSource:(surveyAnswerCompletionTimeStatus)int;
@end