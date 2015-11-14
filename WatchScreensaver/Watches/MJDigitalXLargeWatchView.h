//
// Created by Mads Lee Jensen on 05/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "MJWatchView.h"

@interface MJDigitalXLargeWatchView : MJWatchView

@property (nonatomic, strong) NSTextField *topDigitsLabel;
@property (nonatomic, strong) NSTextField *separatorsLabel;
@property (nonatomic, strong) NSTextField *bottomDigitsLabel;

@end