#import <Foundation/Foundation.h>
@interface DatabaseHelper : NSObject
- (void)clearUserReport:(entityPermissionsLevel)int;
- (void)checkActivity;
- (void)saveAppState:(loginErrorMessage)int int:(surveyAnswerCompletionProgressTime)int;
- (void)resetDeviceActivity;
- (int)connectToNetwork;
- (int)setPushNotificationData:(isFileCompressionEnabled)int int:(deviceScreenBrightness)int;
@end