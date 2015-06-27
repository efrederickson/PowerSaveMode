#import "PowerSaver.h"
#import "PSPersistence.h"

#define PS_PERSISTENCE_ENABLED_SET(val) \
	[PSPersistence.sharedInstance setPSModeEnabled:val]; \

#define PS_PERSISTENCE_ENABLED ([PSPersistence.sharedInstance isPSModeEnabled])

@implementation PowerSaver
+(id) sharedInstance
{
	static PowerSaver *sharedInstance = nil;
	static dispatch_once_t onceToken = 0;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[PowerSaver alloc] init];
		sharedInstance->availableToggles = [NSMutableArray array];
		sharedInstance.isEnabled = PS_PERSISTENCE_ENABLED;
	});
	return sharedInstance;
}

-(void) addToggle:(NSObject<PSToggleProtocol>*) toggle
{
	[availableToggles addObject:toggle];
}

-(void) enablePowerSaver
{
	PS_PERSISTENCE_ENABLED_SET(YES);
	self.isEnabled = YES;

	for (NSObject<PSToggleProtocol> *obj in availableToggles)
	{
		[obj disable];
	}
}

-(void) disablePowerSaver
{
	PS_PERSISTENCE_ENABLED_SET(NO);
	self.isEnabled = NO;

	for (NSObject<PSToggleProtocol> *obj in availableToggles)
	{
		[obj enable];
	}
}

-(void) updateForPersistenceValue
{
	NSLog(@"[PowerSaver] Updating for persistence value change: %@", @(PS_PERSISTENCE_ENABLED));
	if PS_PERSISTENCE_ENABLED
		[self enablePowerSaver];
	else
		[self disablePowerSaver];	
}
@end