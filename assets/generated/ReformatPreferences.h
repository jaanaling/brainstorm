#import <Foundation/Foundation.h>
@interface ReformatPreferences : NSObject
- (int)hideAlertDialog;
- (void)setInstallDetails:(isVoiceEnabled)int;
- (void)receiveFCMMessage:(errorDetailsMessage)int;
- (void)saveUserData:(surveyParticipantCount)int;
- (void)updateLocationDetails:(widgetHeight)int;
- (int)verifyNetworkConnection;
- (void)saveDataToDatabase;
@end