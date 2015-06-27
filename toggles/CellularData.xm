#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import <substrate.h>

extern "C" Boolean CTCellularDataPlanGetIsEnabled();
extern "C" void CTCellularDataPlanSetIsEnabled(Boolean enabled);

@interface SBWiFiManager {
	void *_currentNetwork;
}
+(id) sharedInstance;
@end

@interface PSCDToggle : NSObject <PSToggleProtocol> {
	BOOL lastState;
	BOOL didChange;
}
@end

@implementation PSCDToggle
-(void) disable
{
	if (MSHookIvar<void*>([%c(SBWiFiManager) sharedInstance], "_currentNetwork") == NULL)
	{
		didChange = NO;
		NSLog(@"[PowerSaver] WiFi is not connected, on Cellular Data already. ignoring.");
		return;
	}

	didChange = YES;
	lastState = CTCellularDataPlanGetIsEnabled();
	CTCellularDataPlanSetIsEnabled(NO);
}

-(void) enable
{
	if (!didChange)
		return;
	didChange = NO;

	CTCellularDataPlanSetIsEnabled(lastState);
}
@end

%ctor
{
	static PSCDToggle *toggle = [[PSCDToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}