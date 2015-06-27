#import "FSSwitchDataSource.h"
#import "FSSwitchPanel.h"
#import "PowerSaver.h"

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
	if (newState == FSSwitchStateOn)
		[[%c(PowerSaver) sharedInstance] enable];
	else
		[[%c(PowerSaver) sharedInstance] disable];
}

@end