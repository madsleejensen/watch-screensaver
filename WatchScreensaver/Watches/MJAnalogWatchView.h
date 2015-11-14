//
// Created by Mads Lee Jensen on 01/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "MJWatchView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface MJAnalogWatchView : MJWatchView

@property (nonatomic, strong) NSImageView *backgroundImageView;
@property (nonatomic, strong) NSImageView *hourHandImageView;
@property (nonatomic, strong) NSImageView *minuteHandImageView;
@property (nonatomic, strong) NSImageView *secondHandImageView;
@property (nonatomic, strong) NSImageView *centerDotImageView;

- (void)onTimeChanged:(double)hour minute:(double)minute second:(double)second;
- (NSString *)prefix;

@end