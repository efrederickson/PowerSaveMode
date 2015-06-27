#import "PowerSaver.h"
#import "PSToggleProtocol.h"

@interface PSICToggle : NSObject <PSToggleProtocol> {
	BOOL lastState;
}
@end

extern "C" Boolean _AXSEnhanceBackgroundContrastEnabled();
extern "C" void _AXSSetEnhanceBackgroundContrastEnabled(BOOL enabled);

@implementation PSICToggle
-(void) disable
{
	lastState = _AXSEnhanceBackgroundContrastEnabled();
	_AXSSetEnhanceBackgroundContrastEnabled(YES);
}

-(void) enable
{
	_AXSSetEnhanceBackgroundContrastEnabled(lastState);
}
@end

%ctor
{
	static PSICToggle *toggle = [[PSICToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}