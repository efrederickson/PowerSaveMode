#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import <substrate.h>
#import "PSPersistence.h"

extern "C" Boolean CTCellularDataPlanGetIsEnabled();
extern "C" void CTCellularDataPlanSetIsEnabled(Boolean enabled);

@interface SBWiFiManager {
	void *_currentNetwork;
}
+(id) sharedInstance;
@end

@interface PSCDToggle : NSObject <PSToggleProtocol>
@end

@implementation PSCDToggle
-(void) disable
{
	if (MSHookIvar<void*>([%c(SBWiFiManager) sharedInstance], "_currentNetwork") == NULL)
	{
		SET_VAL(@NO, @"didChange");
		NSLog(@"[PowerSaver] WiFi is not connected, on Cellular Data already. ignoring.");
		return;
	}

	SET_VAL(@YES, @"didChange");
	SET_STATE(CTCellularDataPlanGetIsEnabled());
	CTCellularDataPlanSetIsEnabled(NO);
}

-(void) enable
{
	BOOL didChange = [GET_VAL(@"didChange") boolValue];
	if (!didChange)
		return;
	SET_VAL(@NO, @"didChange");

	CTCellularDataPlanSetIsEnabled(GET_STATE);
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.cellulardata"; }
-(NSString*) displayName { return @"Disable Cellular Data if on WiFi"; }
@end

%ctor
{
	static PSCDToggle *toggle = [[PSCDToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}