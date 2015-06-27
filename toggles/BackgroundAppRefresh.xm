#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

@interface PSBARToggle : NSObject<PSToggleProtocol>
@end

@interface MCProfileConnection : NSObject
+ (id)sharedConnection;
- (BOOL)isAutomaticAppUpdatesAllowed;
- (void)setAutomaticAppUpdatesAllowed:(BOOL)arg1;
@end

@implementation PSBARToggle
- (void) disable
{
	SET_STATE([[%c(MCProfileConnection) sharedConnection] isAutomaticAppUpdatesAllowed]);
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:NO];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, NO);
}

- (void) enable
{
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:GET_STATE];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, NO);
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.backgroundapprefresh"; }
-(NSString*) displayName { return @"Disable Background App Refresh"; }
@end

%ctor
{
	static PSBARToggle *toggle = [[PSBARToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}