//
//  AppDelegate.h
//  BluetoothKeyboard
//
//  Created by bapu on 15/5/29.
//  Copyright (c) 2015年 bapu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "BluetoothKeyboard.h"

@interface AppDelegate : NSObject <NSApplicationDelegate, NSTextFieldDelegate>{
    NSString *_inputString;
    BluetoothKeyboard *_bluetoothKeyboard;
    NSArray *_pairedDevice;
}

@property(nonatomic, copy) NSString *inputString;
@property(nonatomic, retain) NSArray *pairedDevices;
@property(nonatomic, retain) BluetoothKeyboard *bluetoothKeyboard;
@property (assign) IBOutlet NSTextField *inputField;
@property (assign) IBOutlet NSPopUpButton *popUpBtn;

- (IBAction)enterPress:(id)sender;
- (IBAction)deletePressed:(id)sender;

@end

