//
//  QRCodeReaderPlugin.m
//  Runner
//
//  Created by Johan Henselmans on 09/10/2017.
//  Copyright © 2017 The Chromium Authors. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QRCodeReaderPlugin.h"
static NSString *const CHANNEL_NAME = @"qrcode_reader";

@implementation QRCodeReaderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    channel = [FlutterMethodChannel
               methodChannelWithName:CHANNEL_NAME
               binaryMessenger:[registrar messenger]];
    UIViewController *viewController = (UIViewController *)registrar.messenger;
//    FlutterWebviewPlugin* instance = [[FlutterWebviewPlugin alloc] initWithViewController:viewController];
//[registrar addMethodCallDelegate:instance channel:channel];
}

- (instancetype)initWithViewController:(UIViewController *)viewController {
    self = [super init];
    if (self) {
        self.viewController = viewController;
    }
    return self;
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getqrcode" isEqualToString:call.method]) {
        [self showWebView:call];
        result(nil);
    } else if ([@"close" isEqualToString:call.method]) {
        [self closeWebView];
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}


- (void)showWebView:(FlutterMethodCall*)call {
    NSString *url = call.arguments[@"url"];
    NSNumber *withJavascript = call.arguments[@"withJavascript"];
    NSNumber *clearCache = call.arguments[@"clearCache"];
    NSNumber *clearCookies = call.arguments[@"clearCookies"];
    NSNumber *fullScreen = call.arguments[@"fullScreen"];
    
    //self.webviewController = [[WebviewController alloc] initWithUrl:url withJavascript:withJavascript clearCache:clearCache clearCookes:clearCookies];
    
    if ([fullScreen boolValue]) {
    //    [self.viewController presentViewController:self.webviewController animated:YES completion:nil];
    } else {
    //    UINavigationController *navigation = [[UINavigationController alloc] initWithRootViewController:self.webviewController];
    //    [self.viewController presentModalViewController:navigation animated:YES];
    }
}

- (void)closeWebView {
    //[self.webviewController dismissViewControllerAnimated:YES completion:^{
        [channel invokeMethod:@"onDestroy" arguments:nil];
    }];
}

@end
