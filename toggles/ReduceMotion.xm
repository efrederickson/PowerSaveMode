#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

@interface PSRMToggle : NSObject <PSToggleProtocol>
@end

extern "C" Boolean _AXSReduceMotionEnabled();
extern "C" void _AXSSetReduceMotionEnabled(BOOL enabled);

@implementation PSRMToggle
-(void) disable
{
	SET_STATE(_AXSReduceMotionEnabled());
	_AXSSetReduceMotionEnabled(YES);
}

-(void) enable
{
	_AXSSetReduceMotionEnabled(GET_STATE);
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.reducemotion"; }
-(NSString*) displayName { return @"Reduce Motion"; }
@end

%ctor
{
	static PSRMToggle *toggle = [[PSRMToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}