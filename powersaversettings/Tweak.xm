#import <Preferences/Preferences.h>
#import <substrate.h>
#import <SettingsKit/SKSpecifierParser.h>
#import "PSPersistence.h"

%hook PrefsListController
-(id)specifiers
{
	bool first = (MSHookIvar<id>(self, "_specifiers") == nil);
	if(first) {
		%orig;
		NSMutableArray *specs = [MSHookIvar<id>(self, "_specifiers") mutableCopy];

		PSSpecifier *spec = [PSSpecifier preferenceSpecifierNamed:@"Battery" target:self set:NULL get:NULL detail:objc_getClass("BatteryUIController") cell:PSLinkCell edit:nil];
		[spec setProperty:[UIImage imageWithContentsOfFile:@"/Library/Application Support/PowerSaverMode/Battery.png"] forKey:@"iconImage"];
		[specs insertObject:spec atIndex:7]; // Bottom of the first section. iOS 9: Under TouchID & Password
		__strong NSArray *&arr = MSHookIvar<NSArray*>(self, "_specifiers");
		arr = specs;
		return specs;
	}
	return MSHookIvar<id>(self, "_specifiers");
}
%end

%group BatteryUsageUI
%hook BatteryUIController
-(NSMutableArray*) specifiers
{
	NSMutableArray *ret = %orig;

    PSSpecifier *group = [PSSpecifier emptyGroupSpecifier];
    [group setProperty:@"Disables some battery-hungry features. This enables Increase Contrast and Reduce Motion, disables Background App Refresh, disables location services, and disables Cellular Data if connected to WiFi. Power Saving Mode will automatically disable when you connect to a power source." forKey:@"footerText"];
    [ret insertObject:group atIndex:0];

	PSSpecifier* spec = [PSSpecifier preferenceSpecifierNamed:@"Power Saving Mode" target:self set:@selector(setPreferenceValue:specifier:) get:@selector(readPreferenceValue:) detail:nil cell:PSSwitchCell edit:nil];
	[spec setProperty:@YES forKey:@"isPowerSavingSpec"];
    [ret insertObject:spec atIndex:1];

	spec = [PSSpecifier preferenceSpecifierNamed:@"Power Saving Options" target:self set:nil get:nil detail:objc_getClass("PowerSaverOptionsListController") cell:PSLinkCell edit:nil];
    [ret insertObject:spec atIndex:2];

    group = [PSSpecifier emptyGroupSpecifier];
    [group setProperty:@"" forKey:@"footerText"];
    [ret insertObject:group atIndex:3];


    return ret;
}

-(void)setPreferenceValue:(id)value specifier:(PSSpecifier*)specifier
{
 	if ([[specifier propertyForKey:@"isPowerSavingSpec"] isEqual:@YES])
 	{
		[[objc_getClass("PSPersistence") sharedInstance] setPSModeEnabled:[value boolValue]];
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.efrederickson.powersaver.settings_changed"), nil, nil, YES);
		return;
 	}
 	%orig;
}

 -(id)readPreferenceValue:(PSSpecifier*)specifier
 {
 	if ([[specifier propertyForKey:@"isPowerSavingSpec"] isEqual:@YES])
		return @([[objc_getClass("PSPersistence") sharedInstance] isPSModeEnabled]);

	return %orig;
 }
%end
%end

void BatteryUsageUIBundleLoadedNotificationFired(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    if (objc_getClass("BatteryUIController") == nil)
        return;
    %init(BatteryUsageUI);
}

%ctor
{
	const char *bundleLoadedObserver = "battery_usage_hax";
	%init;
	CFNotificationCenterAddObserver(CFNotificationCenterGetLocalCenter(),
                                        bundleLoadedObserver,
                                        BatteryUsageUIBundleLoadedNotificationFired,
                                        (CFStringRef)
                                        NSBundleDidLoadNotification,
                                        (const void*)[NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/BatteryUsageUI.bundle"],
                                        CFNotificationSuspensionBehaviorCoalesce);

	[[NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/BatteryUsageUI.bundle"] load];
}