#import "PowerSaver.h"
#import "PSToggleProtocol.h"

@interface PSRMToggle : NSObject <PSToggleProtocol> {
	BOOL lastState;
}
@end

extern "C" Boolean _AXSReduceMotionEnabled();
extern "C" void _AXSSetReduceMotionEnabled(BOOL enabled);

@implementation PSRMToggle
-(void) disable
{
	NSLog(@"[PowerSaver] disabling reduce motion");
	lastState = _AXSReduceMotionEnabled();
	_AXSSetReduceMotionEnabled(YES);
}

-(void) enable
{
	_AXSSetReduceMotionEnabled(lastState);
}
@end

%ctor
{
	static PSRMToggle *toggle = [[PSRMToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}