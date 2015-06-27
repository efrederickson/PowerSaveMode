#import <CoreLocation/CoreLocation.h>
#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import <substrate.h>
#import "PSPersistence.h"

@interface CLLocationManager (PowerSaver)
+ (BOOL)locationServicesEnabled;
+ (void)setLocationServicesEnabled:(BOOL) newValue;
@end

@interface PSLSToggle : NSObject <PSToggleProtocol>
@end

@implementation PSLSToggle
-(void) disable
{
	NSLog(@"[PowerSaver] disabling location Services");
	SET_STATE([CLLocationManager locationServicesEnabled]);
    [CLLocationManager setLocationServicesEnabled:NO];
}

-(void) enable
{
	NSLog(@"[PowerSaver] restoring location Services");
    [CLLocationManager setLocationServicesEnabled:GET_STATE];
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.locationservices"; }
-(NSString*) displayName { return @"Disable Location Services"; }
@end

%ctor
{
	static PSLSToggle *toggle = [[PSLSToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
}