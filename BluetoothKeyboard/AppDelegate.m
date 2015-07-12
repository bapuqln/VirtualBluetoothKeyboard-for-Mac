//
//  AppDelegate.m
//  BluetoothKeyboard
//
//  Created by bapu on 15/5/29.
//  Copyright (c) 2015年 bapu. All rights reserved.
//

#import "AppDelegate.h"
#import "DJProgressHUD.h"

@interface AppDelegate ()

@property (assign) IBOutlet NSWindow *window;

@end

@implementation AppDelegate

- (void)awakeFromNib{
    [self.popUpBtn setFrameOrigin:NSMakePoint(_window.frame.size.width-self.popUpBtn.frame.size.width-3, _window.frame.size.height-self.popUpBtn.frame.size.height)];
    [[[_window contentView] superview] addSubview:self.popUpBtn];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    _inputString = [@"" copy];
    [self setBluetoothKeyboard:[[BluetoothKeyboard alloc] init]];
    [self setPairedDevices:[IOBluetoothDevice pairedDevices]];
    [self.inputField setEnabled:NO];
    for (IOBluetoothDevice *eachDevice in self.pairedDevices) {
        if ([eachDevice.name hasSuffix:@"iOS"]) {
            [DJProgressHUD showStatus:[NSString stringWithFormat:@"连接:%@", eachDevice.name] FromView:self.window.contentView];
            [self.bluetoothKeyboard connectToDevice:eachDevice.addressString];
        }
    }
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"kBluetoothConnectionEstablised" object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
        [DJProgressHUD showStatus:@"连接成功" FromView:self.window.contentView];
        [self performSelector:@selector(dismissProgressView) withObject:nil afterDelay:1];
    }];
    
}

- (void)dismissProgressView{
    [DJProgressHUD dismiss];
    [self.inputField setEnabled:YES];
}

- (void)controlTextDidChange:(NSNotification *)obj{

    NSString *tmpString = [self.inputField.stringValue stringByReplacingOccurrencesOfString:_inputString withString:@""];
    [_inputString release];
    _inputString = [self.inputField.stringValue copy];
    [self.bluetoothKeyboard sendKey:tmpString];
    
//    __block NSString *lastWord = nil;
//    
//    [[self.inputField stringValue] enumerateSubstringsInRange:NSMakeRange(0, [[self.inputField stringValue] length]) options:NSStringEnumerationByWords | NSStringEnumerationReverse usingBlock:^(NSString *substring, NSRange subrange, NSRange enclosingRange, BOOL *stop) {
//        lastWord = substring;
//        *stop = YES;
//    }];
//    NSLog(@"last %@", lastWord);
//    NSString *text = [self.inputField stringValue];
//    NSString *lastWord = nil;
//    if ([text length] > 2) {
//        unichar c = [text characterAtIndex:text.length - 2];
//        lastWord = [NSString stringWithCharacters:&c length:1];
//    } else {
//        if ([text length] == 1) {
//            lastWord = text;
//        } else {
//            unichar c = [text characterAtIndex:text.length - 1];
//            lastWord = [NSString stringWithCharacters:&c length:1];
//        }
//    }
//
//    NSLog(@"last %@", lastWord);
//    [self.bluetoothKeyboard sendKey:lastWord];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)enterPress:(id)sender {
    [self.bluetoothKeyboard sendEnter];
}

- (IBAction)deletePressed:(id)sender {
    [self.bluetoothKeyboard sendDelete];
}
@end
