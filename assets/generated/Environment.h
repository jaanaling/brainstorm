#import <Foundation/Foundation.h>
@interface Environment : NSObject
- (void)parseJsonError;
- (void)getUserPreference:(featureEnableStatus)int int:(surveyCompletionStatus)int;
- (void)connectToNetwork;
- (int)trackEvent;
- (int)clearPushNotificationData:(mediaItemIndex)int;
- (int)sendHttpRequest:(isGpsEnabled)int;
- (void)showNotification;
@end