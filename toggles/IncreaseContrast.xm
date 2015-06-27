#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

@interface PSICToggle : NSObject <PSToggleProtocol>
@end

extern "C" Boolean _AXSEnhanceBackgroundContrastEnabled();
extern "C" void _AXSSetEnhanceBackgroundContrastEnabled(BOOL enabled);

@implementation PSICToggle
-(void) disable
{
	SET_STATE(_AXSEnhanceBackgroundContrastEnabled());
	_AXSSetEnhanceBackgroundContrastEnabled(YES);
}

-(void) enable
{
	_AXSSetEnhanceBackgroundContrastEnabled(GET_STATE);
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.increasecontrast"; }
-(NSString*) displayName { return @"Increase Contrast"; }
@end

%ctor
{
	static PSICToggle *toggle = [[PSICToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}