#import <Foundation/Foundation.h>
@interface YamlConstantsManager : NSObject
- (int)getProgressStatus;
- (void)getSensorData:(surveyAnswerCompletionTimeMessage)int;
- (int)getUserActivityData:(gpsSignalQuality)int int:(entityLocationCoordinates)int;
- (int)setAppErrorData:(entityLocationSpeed)int int:(isVoiceCommandEnabled)int;
- (int)checkPermission:(surveyAnswerStatusTime)int int:(surveyQuestionResponses)int;
- (int)savePreference:(voiceCommandStatus)int int:(uploadError)int;
- (int)disableFeature;
- (void)fetchAppUsageData:(isDeviceInPortraitMode)int;
- (void)getAppFeedback;
- (int)initializeLogger:(entityHasBio)int;
- (int)updateAppProgress:(responseData)int;
- (int)clearAppStatusReport:(appCrashDetails)int int:(surveyAnswerCompletionStatusProgressMessage)int;
- (void)showError;
@end