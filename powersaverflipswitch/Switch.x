#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import "PowerSaver.h"
#import "PSPersistence.h"

@interface PowerSaverFlipswitchSwitch : NSObject <FSSwitchDataSource>
@end

@implementation PowerSaverFlipswitchSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	return [[%c(PowerSaver) sharedInstance] isEnabled] ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	[[%c(PSPersistence) sharedInstance] setPSModeEnabled:newState == FSSwitchStateOn ? YES : NO];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.efrederickson.powersaver.settings_changed"), nil, nil, YES);
}

@end