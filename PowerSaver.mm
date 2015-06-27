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
	if ([NSBundle.mainBundle.bundleIdentifier isEqual:@"com.apple.springboard"] == NO)
		@throw [NSException exceptionWithName:@"NotSpringboardException" reason:@"Cannot start PowerSaver outside of SpringBoard" userInfo:nil];

	if (self.isEnabled)
		return;

	PS_PERSISTENCE_ENABLED_SET(YES);
	self.isEnabled = YES;

	NSLog(@"[PowerSaver] enabling power saver");

	for (NSObject<PSToggleProtocol> *obj in availableToggles)
	{
		if ([PSPersistence.sharedInstance isToggleEnabled:obj.identifier] == NO)
			continue;
		[obj disable];
	}
}

-(void) disablePowerSaver
{
	if ([NSBundle.mainBundle.bundleIdentifier isEqual:@"com.apple.springboard"] == NO)
		@throw [NSException exceptionWithName:@"NotSpringboardException" reason:@"Cannot start PowerSaver outside of SpringBoard" userInfo:nil];

	if (!self.isEnabled)
		return;

	PS_PERSISTENCE_ENABLED_SET(NO);
	self.isEnabled = NO;

	NSLog(@"[PowerSaver] disabling power saver");

	for (NSObject<PSToggleProtocol> *obj in availableToggles)
	{
		if ([PSPersistence.sharedInstance isToggleEnabled:obj.identifier] == NO)
			continue;
		[obj enable];
	}
}

-(void) updateForPersistenceValue
{
	if PS_PERSISTENCE_ENABLED
		[self enablePowerSaver];
	else
		[self disablePowerSaver];	
}

-(NSArray*) availableToggles
{
	return availableToggles;
}
@end