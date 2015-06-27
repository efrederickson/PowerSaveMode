#import "PowerSaver.h"
#import "PSToggleProtocol.h"

@interface PSBARToggle : NSObject<PSToggleProtocol> {
	BOOL lastState;
}
@end

@interface MCProfileConnection : NSObject
+ (id)sharedConnection;
- (BOOL)isAutomaticAppUpdatesAllowed;
- (void)setAutomaticAppUpdatesAllowed:(BOOL)arg1;
@end

@implementation PSBARToggle
- (void) disable
{
	lastState = [[%c(MCProfileConnection) sharedConnection] isAutomaticAppUpdatesAllowed];
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:NO];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, NO);
}

- (void) enable
{
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:lastState];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, NO);
}
@end

%ctor
{
	static PSBARToggle *toggle = [[PSBARToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}