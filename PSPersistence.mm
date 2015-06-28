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


-(BOOL) isToggleEnabled:(NSString*)ident
{
	id val = [prefs valueForKey:[NSString stringWithFormat:@"Enabled-%@",ident]];
	return val ? [val boolValue] : YES;
}

-(void) setToggle:(NSString*)ident enabled:(BOOL)value
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH] ?: [NSMutableDictionary dictionary];
	dict[[NSString stringWithFormat:@"Enabled-%@",ident]] = @(value);
	[dict writeToFile:FILE_PATH atomically:YES];
	
	prefs = dict;
}

-(BOOL) isToggleStateOn:(NSString*)ident
{
	id val = [prefs valueForKey:[NSString stringWithFormat:@"State-%@",ident]];
	return val ? [val boolValue] : NO;
}

-(void) setToggleState:(BOOL)value forIdentifier:(NSString*)ident
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH] ?: [NSMutableDictionary dictionary];
	dict[[NSString stringWithFormat:@"State-%@",ident]] = @(value);
	[dict writeToFile:FILE_PATH atomically:YES];
	
	prefs = dict;
}

-(id) getValue:(NSString*)valName forIdentifier:(NSString*)identifier
{
	id val = [prefs valueForKey:[NSString stringWithFormat:@"ExtraVal-%@-%@",identifier,valName]];
	return val;
}

-(void) setValue:(id)value forName:(NSString*)valName forIdentifier:(NSString*)identifier
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:FILE_PATH] ?: [NSMutableDictionary dictionary];
	dict[[NSString stringWithFormat:@"ExtraVal-%@-%@",identifier,valName]] = value;
	[dict writeToFile:FILE_PATH atomically:YES];
	
	prefs = dict;
}
@end