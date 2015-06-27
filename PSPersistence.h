@interface PSPersistence : NSObject
+(instancetype) sharedInstance;

-(BOOL) isPSModeEnabled;
-(void) setPSModeEnabled:(BOOL)value;
@end