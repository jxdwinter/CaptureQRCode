//
//  ViewController.m
//  CaptureQRCode
//
//  Created by Xiaodong Jiang on 6/16/15.
//  Copyright (c) 2015 jxdwinter. All rights reserved.
//

#import "ViewController.h"
#import <ZXingObjC/ZXingObjC.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ResultViewController.h"

@interface ViewController ()<ZXCaptureDelegate>

@property (nonatomic, strong) ZXCapture *capture;
@property (nonatomic, assign) BOOL hasScannedResult;

@end

@implementation ViewController

#pragma mark - View Controller Methods

- (void)dealloc {
    [self.capture.layer removeFromSuperlayer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.camera = self.capture.back;
    self.capture.focusMode = AVCaptureFocusModeContinuousAutoFocus;
    self.capture.rotation = 90.0f;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.capture.delegate = self;
    self.capture.layer.frame = self.view.bounds;
    self.capture.scanRect = self.view.bounds;
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        self.hasScannedResult = NO;
        [self.capture start];
    });
}

#pragma mark - Private Methods

- (NSString *)barcodeFormatToString:(ZXBarcodeFormat)format {
    switch (format) {
        case kBarcodeFormatAztec:
            return @"Aztec";
            
        case kBarcodeFormatCodabar:
            return @"CODABAR";
            
        case kBarcodeFormatCode39:
            return @"Code 39";
            
        case kBarcodeFormatCode93:
            return @"Code 93";
            
        case kBarcodeFormatCode128:
            return @"Code 128";
            
        case kBarcodeFormatDataMatrix:
            return @"Data Matrix";
            
        case kBarcodeFormatEan8:
            return @"EAN-8";
            
        case kBarcodeFormatEan13:
            return @"EAN-13";
            
        case kBarcodeFormatITF:
            return @"ITF";
            
        case kBarcodeFormatPDF417:
            return @"PDF417";
            
        case kBarcodeFormatQRCode:
            return @"QR Code";
            
        case kBarcodeFormatRSS14:
            return @"RSS 14";
            
        case kBarcodeFormatRSSExpanded:
            return @"RSS Expanded";
            
        case kBarcodeFormatUPCA:
            return @"UPCA";
            
        case kBarcodeFormatUPCE:
            return @"UPCE";
            
        case kBarcodeFormatUPCEANExtension:
            return @"UPC/EAN extension";
            
        default:
            return @"Unknown";
    }
}

#pragma mark - ZXCaptureDelegate Methods

- (void)captureResult:(ZXCapture *)capture result:(ZXResult *)result {
    if (!result) return;
    if(self.hasScannedResult == NO){
        self.hasScannedResult = YES;
        [self.capture stop];
        ResultViewController *resultViewController = [[ResultViewController alloc] init];
        resultViewController.result = result.text;
        [self.navigationController pushViewController:resultViewController animated:YES];
        
    }else{
        return;
    }
}

@end
