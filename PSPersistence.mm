#import "PSPersistence.h"

#define FILE_PATH @"/var/mobile/Library/Preferences/com.efrederickson.powersaver.plist"

@implementation PSPersistence
+(instancetype) sharedInstance
{
	static PSPersistence *sharedInstance = nil;
	static dispatch_once_t onceToken = 0;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[PSPersistence alloc] init];
	});
	return sharedInstance;
}

-(BOOL) isPSModeEnabled
{
	return [[[NSDictionary dictionaryWithContentsOfFile:FILE_PATH] valueForKey:@"psModeEnabled"] boolValue];
}
-(void) setPSModeEnabled:(BOOL)value
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH] ?: [NSMutableDictionary dictionary];
	dict[@"psModeEnabled"] = @(value);
	[dict writeToFile:FILE_PATH atomically:YES];
}
@end