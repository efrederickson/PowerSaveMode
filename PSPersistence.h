@interface PSPersistence : NSObject {
	NSDictionary *prefs;
}
+(instancetype) sharedInstance;

-(void) loadPrefs;

-(BOOL) isPSModeEnabled;
-(void) setPSModeEnabled:(BOOL)value;
@end