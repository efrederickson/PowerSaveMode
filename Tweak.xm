#import "PowerSaver.h"
#import "PSPersistence.h"
#import "headers.h"

@interface SBUIController
-(BOOL) isOnAC;
-(BOOL) isBatteryCharging;
@end

BOOL wasChanged = NO;

%hook UIStatusBarBatteryItemView
-(_UILegibilityImageSet*) contentsImage
{
	if (!PSPersistence.sharedInstance.isPSModeEnabled)
		return %orig;

	_UILegibilityImageSet *original = %orig;

	UIColor *color = [UIColor colorWithRed:255/255.0f green:197/255.0f blue:0/255.0f alpha:1.0f];
	if (color && [color _isSimilarToColor:[UIColor blackColor] withinPercentage:0.2] == NO)
		original.image = [original.image _flatImageWithColor:color];
    
	return original;
}

- (BOOL)updateForNewData:(id)arg1 actions:(int)arg2
{
	BOOL ret = wasChanged || %orig;
	wasChanged = NO;
	return ret;
}
%end

%hook SBUIController
-(void) ACPowerChanged
{
	%orig;

	BOOL isOnAC = [self isBatteryCharging];
	if (isOnAC)
	{
		[PSPersistence.sharedInstance setPSModeEnabled:NO];
		CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.efrederickson.powersaver.settings_changed"), nil, nil, YES);
	}
}
%end

void reloadSettings(CFNotificationCenterRef center,
                    void *observer,
                    CFStringRef name,
                    const void *object,
                    CFDictionaryRef userInfo)
{
	if ([NSBundle.mainBundle.bundleIdentifier isEqual:@"com.apple.springboard"])
		[PowerSaver.sharedInstance updateForPersistenceValue];

	wasChanged = YES;
	[UIApplication.sharedApplication.statusBar forceUpdateData:YES];
}

%ctor
{
	if ([NSBundle.mainBundle.bundleIdentifier isEqual:@"com.apple.springboard"])
		[PowerSaver sharedInstance]; // initialize
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, &reloadSettings, CFSTR("com.efrederickson.powersaver.settings_changed"), NULL, 0);
}