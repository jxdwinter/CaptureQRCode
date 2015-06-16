//
//  ResultViewController.m
//  CaptureQRCode
//
//  Created by Xiaodong Jiang on 6/16/15.
//  Copyright (c) 2015 jxdwinter. All rights reserved.
//

#import "ResultViewController.h"

@implementation ResultViewController

- (void)viewDidLoad{
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 100.0, self.view.frame.size.width - 20.0, 20.0)];
    label.text = self.result;
    [self.view addSubview:label];
}

@end
