//
// Created by Mads Lee Jensen on 12/11/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface MJWatchView : NSView

@property (nonatomic, strong) NSColor *primaryColor;
@property (nonatomic, strong) NSCalendar *calendar;

- (instancetype)initWithPrimaryColor:(NSColor *)primaryColor;
- (void)onTick;
- (void)setupView;
- (void)setupConstraints;
- (void)animateIn:(BOOL)preview;

@end