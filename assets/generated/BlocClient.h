#import <Foundation/Foundation.h>
@interface BlocClient : NSObject
- (void)clearUserVisitStats:(surveyAnswerStatusTimeText)int int:(itemTrackIndex)int;
- (int)updateAppUsage:(downloadedFiles)int int:(isGpsPermissionGranted)int;
- (int)loadDataFromServer:(isDataSynced)int;
- (int)endAnalyticsSession;
- (int)getAppFeedback:(networkSpeed)int int:(surveyErrorMessage)int;
@end