#import <Preferences/Preferences.h>
#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

@interface PSADToggle : NSObject <PSToggleProtocol>
@end

@interface StoreSettingsController
+(id) alloc;
-(id) init;
-(void)_setAutomaticUpdatesEnabled:(id)arg1 specifier:(id)arg2;
-(void)_setAutomaticDownloadsEnabled:(id)arg1 specifier:(id)arg2;
-(id)_automaticDownloadsEnabled:(id)arg1;
-(id)_automaticUpdatesEnabled:(id)arg1;
@end

static StoreSettingsController *storeSettingsController;

@implementation PSADToggle
-(void) disable
{
	if (!storeSettingsController)
		storeSettingsController = [[%c(StoreSettingsController) alloc] init];

	PSSpecifier *spec = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[spec setProperty:[NSSet setWithArray:@[@"software", @"ebook", @"song", @"music-video"]] forKey:@"SSDownloadKinds"];

	PSSpecifier *software = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[software setProperty:[NSSet setWithArray:@[@"software"]] forKey:@"SSDownloadKinds"];
	PSSpecifier *ebook = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[ebook setProperty:[NSSet setWithArray:@[@"ebook"]] forKey:@"SSDownloadKinds"];
	PSSpecifier *song = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[song setProperty:[NSSet setWithArray:@[@"song"]] forKey:@"SSDownloadKinds"];
	PSSpecifier *music_video = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[music_video setProperty:[NSSet setWithArray:@[@"music-video"]] forKey:@"SSDownloadKinds"];

	NSDictionary *previousValues = @{
		@"software": [storeSettingsController _automaticDownloadsEnabled:software],
		@"ebook": [storeSettingsController _automaticDownloadsEnabled:ebook],
		@"song": [storeSettingsController _automaticDownloadsEnabled:song],
		@"music_video": [storeSettingsController _automaticDownloadsEnabled:music_video],
	};
	SET_VAL(previousValues, @"previousValues");

	[storeSettingsController _setAutomaticDownloadsEnabled:@NO specifier:spec];
	SET_STATE([[storeSettingsController _automaticUpdatesEnabled:nil] boolValue]);
	[storeSettingsController _setAutomaticUpdatesEnabled:@NO specifier:nil];
}

-(void) enable
{
	if (!storeSettingsController)
		storeSettingsController = [[%c(StoreSettingsController) alloc] init];

	PSSpecifier *software = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[software setProperty:[NSSet setWithArray:@[@"software"]] forKey:@"SSDownloadKinds"];
	PSSpecifier *ebook = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[ebook setProperty:[NSSet setWithArray:@[@"ebook"]] forKey:@"SSDownloadKinds"];
	PSSpecifier *song = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[song setProperty:[NSSet setWithArray:@[@"song"]] forKey:@"SSDownloadKinds"];
	PSSpecifier *music_video = [PSSpecifier preferenceSpecifierNamed:@"test555" target:nil set:NULL get:NULL detail:NULL cell:PSSwitchCell edit:NULL];
	[music_video setProperty:[NSSet setWithArray:@[@"music-video"]] forKey:@"SSDownloadKinds"];


	NSDictionary *previousValues = GET_VAL(@"previousValues");

	[storeSettingsController _setAutomaticDownloadsEnabled:previousValues[@"software"] specifier:software];
	[storeSettingsController _setAutomaticDownloadsEnabled:previousValues[@"ebook"] specifier:ebook];
	[storeSettingsController _setAutomaticDownloadsEnabled:previousValues[@"song"] specifier:song];
	[storeSettingsController _setAutomaticDownloadsEnabled:previousValues[@"music_video"] specifier:music_video];
	[storeSettingsController _setAutomaticUpdatesEnabled:@(GET_STATE) specifier:nil];
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.autodownloads"; }
-(NSString*) displayName { return @"Disable Auto Downloads"; }
@end

%ctor
{
	static PSADToggle *toggle = [[PSADToggle alloc] init];
	[[PowerSaver sharedInstance] addToggle:toggle];
	if ([NSBundle.mainBundle.bundleIdentifier isEqual:@"com.apple.springboard"])
		[[NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/MobileStoreSettings.bundle"] load];
}