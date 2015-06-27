#import "PowerSaverOptionsListController.h"
#import "PowerSaver.h"
#import "PSPersistence.h"

@implementation PowerSaverOptionsListController
-(BOOL) showHeartImage { return NO; }

-(NSArray*) customSpecifiers 
{
	NSMutableArray *ret = [NSMutableArray array];

	PowerSaver *ps = [objc_getClass("PowerSaver") sharedInstance];
	for (NSObject<PSToggleProtocol> *toggle in ps.availableToggles)
	{
		[ret addObject:@{
			@"cell": @"PSSwitchCell",
			@"default": @([PSPersistence.sharedInstance isToggleEnabled:toggle.identifier]),
			@"identifier": toggle.identifier,
			@"label": toggle.displayName
		}];
		[ret addObject:@{ }];
	}

	return ret;
}

-(id)readPreferenceValue:(PSSpecifier*)specifier
{
	return @([PSPersistence.sharedInstance isToggleEnabled:[specifier propertyForKey:@"identifier"]]);
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier
{
	[PSPersistence.sharedInstance setToggle:[specifier propertyForKey:@"identifier"] enabled:[value boolValue]];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.efrederickson.powersaver.settings_changed"), nil, nil, YES);
	return;
}
@end