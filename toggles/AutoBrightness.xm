#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

extern "C" void GSSendAppPreferencesChanged(CFStringRef bundleID, CFStringRef key);

@interface PSABToggle : NSObject<PSToggleProtocol>
@end

@implementation PSABToggle
- (void) disable
{
	CFPreferencesAppSynchronize(CFSTR("com.apple.backboardd"));
	SET_STATE(CFPreferencesGetAppBooleanValue(CFSTR("BKEnableALS"), CFSTR("com.apple.backboardd"), NULL));

    CFPreferencesSetAppValue(CFSTR("BKEnableALS"), kCFBooleanFalse, CFSTR("com.apple.backboardd"));
    CFPreferencesAppSynchronize(CFSTR("com.apple.backboardd"));
    GSSendAppPreferencesChanged(CFSTR("com.apple.backboardd"), CFSTR("BKEnableALS"));
}

- (void) enable
{
    CFPreferencesSetAppValue(CFSTR("BKEnableALS"), GET_STATE ? kCFBooleanTrue : kCFBooleanFalse, CFSTR("com.apple.backboardd"));
    CFPreferencesAppSynchronize(CFSTR("com.apple.backboardd"));
    GSSendAppPreferencesChanged(CFSTR("com.apple.backboardd"), CFSTR("BKEnableALS"));
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.autobrightness"; }
-(NSString*) displayName { return @"Turn off AutoBrightness"; }
@end

%ctor
{
    static PSABToggle *toggle = [[PSABToggle alloc] init];
    [[PowerSaver sharedInstance] addToggle:toggle];
}