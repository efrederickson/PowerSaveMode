#import "PowerSaver.h"
#import "PSToggleProtocol.h"
#import "PSPersistence.h"

@interface BluetoothDevice
- (_Bool)connected;
- (_Bool)paired;
- (id)description;
- (int)type;
- (id)address;
- (id)name;
@end
@interface BluetoothManager
+ (id)sharedInstance;
- (_Bool)connected;
- (id)connectedDevices;
- (id)connectingDevices;
- (id)pairedDevices;
- (void)unpairDevice:(id)arg1;
- (void)resetDeviceScanning;
- (_Bool)deviceScanningInProgress;
- (_Bool)deviceScanningEnabled;
- (_Bool)wasDeviceDiscovered:(id)arg1;
- (void)_removeDevice:(id)arg1;
- (id)addDeviceIfNeeded:(struct BTDeviceImpl *)arg1;
- (void)_connectedStatusChanged;
- (BOOL)powered;
- (BOOL)enabled;
- (BOOL)setPowered:(BOOL)powered;
- (void)setEnabled:(BOOL)enabled;
@end

@interface PSBTToggle : NSObject<PSToggleProtocol>
@end

@implementation PSBTToggle
- (void) disable
{
    BluetoothManager *man = [%c(BluetoothManager) sharedInstance];
    SET_STATE([man powered]);
    SET_VAL(@([man enabled]), @"enabled");
    [man setPowered:NO]; 
    [man setEnabled:NO]; 
}

- (void) enable
{
    BluetoothManager *man = [%c(BluetoothManager) sharedInstance];
    [man setPowered:GET_STATE];
    [man setEnabled:[GET_VAL(@"enabled") boolValue]];
}

-(NSString*) identifier { return @"com.efrederickson.powersaver.toggles.bluetooth"; }
-(NSString*) displayName { return @"Disable Bluetooth if no connected devices"; }
@end

%ctor
{
    static PSBTToggle *toggle = [[PSBTToggle alloc] init];
    [[PowerSaver sharedInstance] addToggle:toggle];
}