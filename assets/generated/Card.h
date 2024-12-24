#import <Foundation/Foundation.h>
@interface Card : NSObject
- (int)sendUserStatusReport;
- (int)refreshContent:(mediaSyncStatus)int int:(surveyQuestionAnswerSubmission)int;
- (void)setSyncStatus:(surveyCompletionStatusMessageTime)int int:(isEntityInactive)int;
- (void)clearSessionStatus:(itemTrackInfo)int;
- (int)logPerformance:(surveyFeedbackStatusMessage)int int:(isMediaLoaded)int;
- (void)saveState:(isEntityLoggedOut)int int:(voiceRecognitionError)int;
- (void)updateProgressStatus:(surveyAnswerCompletionStatusProgress)int int:(taskResumeTime)int;
- (int)setMessageNotificationData:(itemCount)int int:(isFileProcessed)int;
- (void)sendSystemErrorData:(isFileValid)int int:(mediaControl)int;
- (void)loadDataFromCache;
- (int)clearContent:(dataPrivacyStatus)int int:(deviceInformation)int;
- (int)checkDeviceFeatures:(surveyQuestionText)int int:(isMusicPlaying)int;
- (int)trackEvent:(isEntityVerified)int int:(isAppReady)int;
- (int)launchApp;
- (void)sendAppNotificationData;
- (int)saveExternalData:(surveyAnswerReviewProgressTimeText)int;
@end