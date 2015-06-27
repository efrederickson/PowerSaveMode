#import "PSToggleProtocol.h"

@interface PowerSaver : NSObject {
	NSMutableArray *availableToggles;
}
+(instancetype) sharedInstance;

@property (nonatomic) BOOL isEnabled;

-(void) addToggle:(NSObject<PSToggleProtocol>*) toggle;

-(void) enablePowerSaver;
-(void) disablePowerSaver;

-(void) updateForPersistenceValue;

-(NSArray*) availableToggles;
@end