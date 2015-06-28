#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

@interface SBMediaController
+ (id)sharedInstance;
- (BOOL)isRingerMuted;
- (void)setRingerMuted:(BOOL)muted;
@end

@interface PSRingerToggle : NSObject<PSToggleProtocol>
@end

@implementation PSRingerToggle
- (void) disable
{
	SET_STATE([[%c(SBMediaController) sharedInstance] isRingerMuted]);
	[[%c(SBMediaController) sharedInstance] setRingerMuted:YES];
}

- (void) enable
{
    [[%c(SBMediaController) sharedInstance] setRingerMuted:GET_STATE];
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.ringer"; }
-(NSString*) displayName { return @"Turn off ringer"; }
@end

%ctor
{
    static PSRingerToggle *toggle = [[PSRingerToggle alloc] init];
    [[PowerSaver sharedInstance] addToggle:toggle];
}