//
//  BluetoothKeyboard.m
//  BluetoothKeyboard
//
//  Created by bapu on 15/5/29.
//  Copyright (c) 2015年 bapu. All rights reserved.
//

#import "BluetoothKeyboard.h"

@implementation BluetoothKeyboard

@synthesize device = _device;
@synthesize deviceAddress = _deviceAddress;
@synthesize deviceName = _deviceName;
@synthesize hidServiceHandle = _hidServiceHandle;
@synthesize deviceIdServiceHandle = _deviceIdServiceHandle;
@synthesize controlChannel = _controlChannel;
@synthesize intruptChannel = _interruptChannel;
@synthesize sdpServiceRecord = _sdpServiceRecord;
@synthesize pnpSdpServiceRecord = _pnpSdpServiceRecord;

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self publisService];
//        [self publishPnpService];
        [IOBluetoothL2CAPChannel registerForChannelOpenNotifications:self selector:@selector(hidControlChannelIncomingOpened:withL2CAPChannel:) withPSM:kBluetoothL2CAPPSMHIDControl direction:kIOBluetoothUserNotificationChannelDirectionAny];
        [IOBluetoothL2CAPChannel registerForChannelOpenNotifications:self selector:@selector(hidInterruptChannelIncomingOpened:withL2CAPChannel:) withPSM:kBluetoothL2CAPPSMHIDInterrupt direction:kIOBluetoothUserNotificationChannelDirectionAny];
        [[IOBluetoothHostController defaultController] setClassOfDevice:0x380540 forTimeInterval:30];
    }
    return self;
}

- (void)sendEnter{
    dispatch_async(dispatch_get_main_queue(), ^{
        char keyDown[] = {
            0xa1,0x01,
            0x00,0x00,
            0x28,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00
        };
        [self.intruptChannel writeAsync:keyDown length:sizeof(keyDown) refcon:nil];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        char keyUp[] = {
            0xa1,0x01,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00
        };
        [self.intruptChannel writeAsync:keyUp length:sizeof(keyUp) refcon:nil];
    });

}

- (void)sendDelete{
    dispatch_async(dispatch_get_main_queue(), ^{
        char keyDown[] = {
            0xa1,0x01,
            0x00,0x00,
            0x2a,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00
        };
        [self.intruptChannel writeAsync:keyDown length:sizeof(keyDown) refcon:nil];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        char keyUp[] = {
            0xa1,0x01,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00
        };
        [self.intruptChannel writeAsync:keyUp length:sizeof(keyUp) refcon:nil];
    });
}

- (void)sendKey:(NSString *)key{
    char keyCode = 0x00;
    key = [key lowercaseString];
    if ([key isEqualToString:@"a"]) {
        keyCode = 0x04;
    } else if ([key isEqualToString:@"b"]){
        keyCode = 0x05;
    }else if ([key isEqualToString:@"c"]){
        keyCode = 0x06;
    }else if ([key isEqualToString:@"d"]){
        keyCode = 0x07;
    }else if ([key isEqualToString:@"e"]){
        keyCode = 0x08;
    }else if ([key isEqualToString:@"f"]){
        keyCode = 0x09;
    }else if ([key isEqualToString:@"g"]){
        keyCode = 0x0a;
    }else if ([key isEqualToString:@"h"]){
        keyCode = 0x0b;
    }else if ([key isEqualToString:@"i"]){
        keyCode = 0x0c;
    }else if ([key isEqualToString:@"j"]){
        keyCode = 0x0d;
    }else if ([key isEqualToString:@"k"]){
        keyCode = 0x0e;
    }else if ([key isEqualToString:@"l"]){
        keyCode = 0x0f;
    }else if ([key isEqualToString:@"m"]){
        keyCode = 0x10;
    }else if ([key isEqualToString:@"n"]){
        keyCode = 0x11;
    }else if ([key isEqualToString:@"o"]){
        keyCode = 0x12;
    }else if ([key isEqualToString:@"p"]){
        keyCode = 0x13;
    }else if ([key isEqualToString:@"q"]){
        keyCode = 0x14;
    }else if ([key isEqualToString:@"r"]){
        keyCode = 0x15;
    }else if ([key isEqualToString:@"s"]){
        keyCode = 0x16;
    }else if ([key isEqualToString:@"t"]){
        keyCode = 0x17;
    }else if ([key isEqualToString:@"u"]){
        keyCode = 0x18;
    }else if ([key isEqualToString:@"v"]){
        keyCode = 0x19;
    }else if ([key isEqualToString:@"w"]){
        keyCode = 0x1a;
    }else if ([key isEqualToString:@"x"]){
        keyCode = 0x1b;
    }else if ([key isEqualToString:@"y"]){
        keyCode = 0x1c;
    }else if ([key isEqualToString:@"z"]){
        keyCode = 0x1d;
    }else if ([key isEqualToString:@" "]){
        keyCode = 0x2c;
    }else if ([key isEqualToString:@"1"]){
        keyCode = 0x1e;
    }else if ([key isEqualToString:@"2"]){
        keyCode = 0x1f;
    }else if ([key isEqualToString:@"3"]){
        keyCode = 0x20;
    }else if ([key isEqualToString:@"4"]){
        keyCode = 0x21;
    }else if ([key isEqualToString:@"5"]){
        keyCode = 0x22;
    }else if ([key isEqualToString:@"6"]){
        keyCode = 0x23;
    }else if ([key isEqualToString:@"7"]){
        keyCode = 0x24;
    }else if ([key isEqualToString:@"8"]){
        keyCode = 0x25;
    }else if ([key isEqualToString:@"9"]){
        keyCode = 0x26;
    }else if ([key isEqualToString:@"0"]){
        keyCode = 0x27;
    }
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        char keyDown[] = {
            0xa1,0x01,
            0x00,0x00,
            keyCode,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00
        };
        [self.intruptChannel writeAsync:keyDown length:sizeof(keyDown) refcon:nil];
    });
    
    dispatch_async(dispatch_get_main_queue(), ^{
        char keyUp[] = {
            0xa1,0x01,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00,
            0x00,0x00
        };
        [self.intruptChannel writeAsync:keyUp length:sizeof(keyUp) refcon:nil];
    });

}

#pragma mark - Decompile Function

- (void)publisService{
    NSString *keyboardDicPath = [[NSBundle mainBundle] pathForResource:@"HIDKeyboardService" ofType:@"plist"];
    NSMutableDictionary *keyboardDic = [NSMutableDictionary dictionaryWithContentsOfFile:keyboardDicPath];
    self.sdpServiceRecord = [IOBluetoothSDPServiceRecord publishedServiceRecordWithDictionary:keyboardDic];
    [self.sdpServiceRecord getServiceRecordHandle:&_deviceIdServiceHandle];
    [self setDeviceIdServiceHandle:_deviceIdServiceHandle];
}

- (void)publishPnpService{
    NSString *deviceIdDicPath = [[NSBundle mainBundle] pathForResource:@"DeviceID-Dictionary" ofType:@"plist"];
    NSMutableDictionary *deviceIdDic = [NSMutableDictionary dictionaryWithContentsOfFile:deviceIdDicPath];
    self.pnpSdpServiceRecord = [IOBluetoothSDPServiceRecord publishedServiceRecordWithDictionary:deviceIdDic];
    [self.pnpSdpServiceRecord getServiceRecordHandle:&_deviceIdServiceHandle];
    [self setDeviceIdServiceHandle:_deviceIdServiceHandle];
}

- (void)connectToDevice:(NSString *)deviceAddress{
    if (deviceAddress) {
        [self setDeviceAddress:deviceAddress];
        [self openControlChannel];
    }
}


- (void)openControlChannel{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KeyboardConnectionConnectingNotificationName" object:nil];

    [self setDevice:[IOBluetoothDevice deviceWithAddressString:[[self deviceAddress] stringByReplacingOccurrencesOfString:@"-" withString:@":"]]];
    IOBluetoothL2CAPChannel *tmpChannel = nil;
    IOReturn openResult = [[self device] openL2CAPChannelAsync:&tmpChannel withPSM:kBluetoothL2CAPPSMHIDControl delegate:self];
    if (openResult != kIOReturnSuccess) {
        
    } else {
        [self setControlChannel:tmpChannel];
    }
}

- (void)openInterruptChannel{

    IOBluetoothL2CAPChannel *tmpChannel = nil;
    
    IOReturn openResult = [[self device] openL2CAPChannelAsync:&tmpChannel withPSM:kBluetoothL2CAPPSMHIDInterrupt delegate:self];
    [self setIntruptChannel:tmpChannel];
}

- (void)connectionEstablished{
    if ([self controlChannel] || [self intruptChannel]) {
        return;
    }

    [self sendConnectionEstablishNotification];
    [self recordConnection];
}

- (void)sendConnectionEstablishNotification{
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:3];
    [dic setValue:[self.device nameOrAddress] forKey:@"name"];
    [dic setValue:[self.device addressString] forKey:@"address"];
    [dic setValue:[NSDate date] forKey:@"timestamp"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"KeyboardConnectionEstablishedNotificationName" object:self userInfo:dic];
}

- (void)recordConnection{

}

- (void)bluetoothState{

}

- (void)connectionEstablistedState{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
}


# pragma mark - L2CAP Delegate

- (void)l2capChannelClosed:(IOBluetoothL2CAPChannel *)l2capChannel{
    NSLog(@"%s", __func__);
}

- (void)l2capChannelData:(IOBluetoothL2CAPChannel *)l2capChannel data:(void *)dataPointer length:(size_t)dataLength{
    NSLog(@"%s", __func__);
    if ([l2capChannel getPSM] == kBluetoothL2CAPPSMHIDControl) {
        NSLog(@"kBluetoothL2CAPPSMHIDControl");
//        [l2capChannel writeAsync:dataPointer length:1 refcon:nil];
    }
//    esi = arg_8;
//    eax = [esi getPSM];
//    if (LOWORD(eax) == 0x11) {
//        var_9 = 0x0;
//        eax = [esi writeAsync:var_9 length:0x1 refcon:0x0];
//    }
//    return;
}

- (void)l2capChannelOpenComplete:(IOBluetoothL2CAPChannel *)l2capChannel status:(IOReturn)error{
    NSLog(@"%s, %d", __func__, error == kIOReturnSuccess);
    if ([l2capChannel getPSM] == kBluetoothL2CAPPSMHIDControl) {
        NSLog(@"kBluetoothL2CAPPSMHIDControl");
//        [l2capChannel writeAsync:dataPointer length:1 refcon:nil];
        [self openInterruptChannel];
        NSLog(@"*******************************************");
//        [self performSelector:@selector(openInterruptChannel) withObject:nil afterDelay:5];
        NSLog(@"*******************************************");

    }
    if ([l2capChannel getPSM] == kBluetoothL2CAPPSMHIDInterrupt) {
//        char key = [@"j" characterAtIndex:@"j".length-1];
//        char packet[] = {
//            key, // keycode
//            0x00, // padding
//            0x00, // LED, padding
//            0x00, 0x00, key, 0x00, 0x00, 0x00, // keycodes
//            0x00, 0x00 // vendor defined
//        };
        /*char packet[] = {
//            0x0d,0x20,0x12,0x00,0x0e,0x00,0x07,
//            0x04,0xa1,0x01,0x00,0x00,0x00,0x00
            0x0d,0x20,
            0x12,0x00,
            0x00,0x0e,
            0x04,0x07,
            0x01,0xa1,
            0x00,0x00,
            0x00,0x00

        };*/
        
//        char packet[] = {
//            //            0x0d,0x20,0x12,0x00,0x0e,0x00,0x07,
//            //            0x04,0xa1,0x01,0x00,0x00,0x00,0x00
//            0xa1,0x01,
//            0x00,0x00,
//            0x0f,0x00,
//            0x00,0x00,
//            0x00,0x00,
//            0x00,0x00,
//            0x00,0x00
//        };
//        
//        NSData *adata = [NSData dataWithBytes:packet length:sizeof(packet)];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"kBluetoothConnectionEstablised" object:nil];
        return;
        dispatch_async(dispatch_get_main_queue(), ^{
            char packet[] = {
                //            0x0d,0x20,0x12,0x00,0x0e,0x00,0x07,
                //            0x04,0xa1,0x01,0x00,0x00,0x00,0x00
                0xa1,0x01,
                0x00,0x00,
                0x0f,0x00,
                0x00,0x00,
                0x00,0x00,
                0x00,0x00,
                0x00,0x00
            };
            [l2capChannel writeAsync:packet length:sizeof(packet) refcon:nil];
        });

//        dispatch_async(dispatch_get_main_queue(), ^{
//            
            char packet1[] = {
                //            0x0d,0x20,0x12,0x00,0x0e,0x00,0x07,
                //            0x04,0xa1,0x01,0x00,0x00,0x00,0x00
                
                0xa1,0x01,
                0x00,0x00,
                0x00,0x00,
                0x00,0x00,
                0x00,0x00,
                0x00,0x00,
                0x00,0x00
            };
            [self.intruptChannel writeAsync:packet1 length:sizeof(packet1) refcon:nil];
//        });
    }
}

- (void)l2capChannelQueueSpaceAvailable:(IOBluetoothL2CAPChannel *)l2capChannel{
    NSLog(@"%s", __func__);
}

- (void)l2capChannelReconfigured:(IOBluetoothL2CAPChannel *)l2capChannel{
    NSLog(@"%s", __func__);
}

- (void)l2capChannelWriteComplete:(IOBluetoothL2CAPChannel *)l2capChannel refcon:(void *)refcon status:(IOReturn)error{
    NSLog(@"%s , %d", __func__, error == kIOReturnSuccess);
}

#pragma mark - Channel Open Notification Callback

- (void)hidControlChannelIncomingOpened:(NSNotification*)note withL2CAPChannel:(IOBluetoothL2CAPChannel*)channel{
    NSLog(@"%s", __func__);
    return;
    if ([channel getPSM] == kBluetoothL2CAPPSMHIDControl) {
        NSLog(@"kBluetoothL2CAPPSMHIDControl");
    }
}

- (void)hidInterruptChannelIncomingOpened:(NSNotification*)note withL2CAPChannel:(IOBluetoothL2CAPChannel*)channel{
    return;
    NSLog(@"%s", __func__);
}

@end
