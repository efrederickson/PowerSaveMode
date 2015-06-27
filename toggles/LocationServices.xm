#import <CoreLocation/CoreLocation.h>
#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import <substrate.h>

@interface CLLocationManager (PowerSaver)
+ (BOOL)locationServicesEnabled;
+ (void)setLocationServicesEnabled:(BOOL) newValue;
@end

@interface PSLSToggle : NSObject <PSToggleProtocol> {
    BOOL lastState;
}
@end

@implementation PSLSToggle
-(void) disable
{
    lastState = [CLLocationManager locationServicesEnabled];
    [CLLocationManager setLocationServicesEnabled:NO];
}

-(void) enable
{
    [CLLocationManager setLocationServicesEnabled:lastState];
}
@end

%ctor
{
	static PSLSToggle *toggle = [[PSLSToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}