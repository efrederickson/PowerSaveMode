@interface PSPersistence : NSObject {
	NSDictionary *prefs;
}
+(instancetype) sharedInstance;

-(void) loadPrefs;

-(BOOL) isPSModeEnabled;
-(void) setPSModeEnabled:(BOOL)value;

-(BOOL) isToggleEnabled:(NSString*)ident;
-(void) setToggle:(NSString*)ident enabled:(BOOL)value;
-(BOOL) isToggleStateOn:(NSString*)ident;
-(void) setToggleState:(BOOL)value forIdentifier:(NSString*)ident;

-(BOOL) getValue:(NSString*)valName forIdentifier:(NSString*)identifier;
-(void) setValue:(BOOL)value forName:(NSString*)valName forIdentifier:(NSString*)identifier;
@end

#define SET_STATE(val) [PSPersistence.sharedInstance setToggleState:val forIdentifier:self.identifier]
#define GET_STATE [PSPersistence.sharedInstance isToggleStateOn:self.identifier]
#define SET_VAL(val, name) [PSPersistence.sharedInstance setValue:val forName:name forIdentifier:self.identifier]
#define GET_VAL(name) [PSPersistence.sharedInstance getValue:name forIdentifier:self.identifier]