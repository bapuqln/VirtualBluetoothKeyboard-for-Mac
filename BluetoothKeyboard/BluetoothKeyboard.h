//
//  BluetoothKeyboard.h
//  BluetoothKeyboard
//
//  Created by bapu on 15/5/29.
//  Copyright (c) 2015年 bapu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <IOBluetooth/IOBluetooth.h>
#import <IOBluetoothUI/IOBluetoothUI.h>
#import <IOBluetooth/IOBluetoothUserLib.h>

@interface BluetoothKeyboard : NSObject<IOBluetoothL2CAPChannelDelegate>{
    unsigned int _hidServiceHandle;
    unsigned int _deviceIdServiceHandle;
    IOBluetoothL2CAPChannel *_controlChannel;
    IOBluetoothL2CAPChannel *_interruptChannel;
    IOBluetoothSDPServiceRecord *_sdpServiceRecord;
    IOBluetoothSDPServiceRecord *_pnpSdpServiceRecord;
    IOBluetoothDevice *_device;
    NSString *_deviceAddress;
    NSString *_deviceName;
    NSDictionary *keyCodeDic;
}

@property (nonatomic, copy) NSString *deviceName;
@property (nonatomic, copy) NSString *deviceAddress;
@property (nonatomic, retain) IOBluetoothDevice *device;
@property (nonatomic, assign) unsigned int deviceIdServiceHandle;
@property (nonatomic, assign) unsigned int hidServiceHandle;
@property (nonatomic, retain) IOBluetoothL2CAPChannel *controlChannel;
@property (nonatomic, retain) IOBluetoothL2CAPChannel *intruptChannel;
@property (nonatomic, retain) IOBluetoothSDPServiceRecord *sdpServiceRecord;
@property (nonatomic, retain) IOBluetoothSDPServiceRecord *pnpSdpServiceRecord;

- (void)connectToDevice:(NSString *)deviceAddress;
- (void)sendKey:(NSString *)key;

- (void)sendEnter;
- (void)sendDelete;
@end
