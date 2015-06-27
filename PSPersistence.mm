#import "PSPersistence.h"

#define FILE_PATH @"/var/mobile/Library/Preferences/com.efrederickson.powersaver.plist"

@implementation PSPersistence
+(instancetype) sharedInstance
{
	static PSPersistence *sharedInstance = nil;
	static dispatch_once_t onceToken = 0;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[PSPersistence alloc] init];
		[sharedInstance loadPrefs];
	});
	return sharedInstance;
}

-(void) loadPrefs
{
	prefs = [NSDictionary dictionaryWithContentsOfFile:FILE_PATH];
}

-(BOOL) isPSModeEnabled
{
	return [[prefs valueForKey:@"psModeEnabled"] boolValue];
}
-(void) setPSModeEnabled:(BOOL)value
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH] ?: [NSMutableDictionary dictionary];
	dict[@"psModeEnabled"] = @(value);
	[dict writeToFile:FILE_PATH atomically:YES];
	
	prefs = dict;
}
@end