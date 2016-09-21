//
// Created by Mads Lee Jensen on 01/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MJAnalogWatchView.h"
#import "NSImage+Utils.h"
#import "MJImageLoader.h"

@implementation MJAnalogWatchView {
}

- (void)setupView {
    [super setupView];

    self.backgroundImageView = [[NSImageView alloc] init];
    [self addSubview:self.backgroundImageView];

    self.hourHandImageView = [[NSImageView alloc] init];
    self.hourHandImageView.wantsLayer = YES;
    [self addSubview:self.hourHandImageView];

    self.minuteHandImageView = [[NSImageView alloc] init];
    self.minuteHandImageView.wantsLayer = YES;
    [self addSubview:self.minuteHandImageView];

    self.secondHandImageView = [[NSImageView alloc] init];
    self.secondHandImageView.wantsLayer = YES;
    [self addSubview:self.secondHandImageView];

    self.centerDotImageView = [[NSImageView alloc] init];
    [self addSubview:self.centerDotImageView];
}

- (void)setupConstraints {
    [super setupConstraints];

    [self.backgroundImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self.hourHandImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self.minuteHandImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self.secondHandImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];

    [self.centerDotImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];

    NSImage *backgroundImage = [MJImageLoader imageNamed:[NSString stringWithFormat:@"%@_background", self.prefix]];
    self.backgroundImageView.image = [backgroundImage resizeToSize:self.bounds.size];

    // http://jwilling.com/blog/osx-animations/ (we need to reset the anchor-point / position every time we changes the layer's transform)
    NSImage *hourHandImage = [MJImageLoader imageNamed:[NSString stringWithFormat:@"%@_hourhand", self.prefix]];
    self.hourHandImageView.image = [hourHandImage resizeToSize:self.bounds.size];
    self.hourHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.hourHandImageView.frame), CGRectGetMidY(self.hourHandImageView.frame));
    self.hourHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);

    NSImage *minuteHandImage = [MJImageLoader imageNamed:[NSString stringWithFormat:@"%@_minutehand", self.prefix]];
    self.minuteHandImageView.image = [minuteHandImage resizeToSize:self.bounds.size];
    self.minuteHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.minuteHandImageView.frame), CGRectGetMidY(self.minuteHandImageView.frame));
    self.minuteHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);

    NSImage *secondHandImage = [MJImageLoader imageNamed:[NSString stringWithFormat:@"%@_secondhand", self.prefix]];
    self.secondHandImageView.image = [secondHandImage resizeToSize:self.bounds.size tint:self.primaryColor];
    self.secondHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.secondHandImageView.frame), CGRectGetMidY(self.secondHandImageView.frame));
    self.secondHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);

    NSImage *centerDotImage = [MJImageLoader imageNamed:@"chrono_centerscrew"];
    self.centerDotImageView.image = [centerDotImage resizeToSize:self.bounds.size];
}

- (void)onTick {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];
    NSDateComponents *components = [self.calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];

    double seconds = floor(timeInterval);
    double miliseconds = (timeInterval - seconds) * 1000;

    double second = components.second + (miliseconds / 1000.0f);
    double minute = components.minute + (second / 60.0f);
    double hour = components.hour + (minute / 60.0f);

    [self onTimeChanged:hour minute:minute second:second];
}

- (void)onTimeChanged:(double)hour minute:(double)minute second:(double)second {
    double hourAngle = 360.0f * (hour / 12.0f);
    double minuteAngle = 360.0f * (minute / 60.0f);
    double secondAngle = 360.0f * (second / 60.0f);

    self.hourHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.hourHandImageView.frame), CGRectGetMidY(self.hourHandImageView.frame));
    self.hourHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.hourHandImageView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(hourAngle), 0, 0, 1.0f);
    
    self.minuteHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.minuteHandImageView.frame), CGRectGetMidY(self.minuteHandImageView.frame));
    self.minuteHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.minuteHandImageView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(minuteAngle), 0, 0, 1.0f);
    
    self.secondHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.secondHandImageView.frame), CGRectGetMidY(self.secondHandImageView.frame));
    self.secondHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    self.secondHandImageView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(secondAngle), 0.0f, 0.0f, 1.0f);
}

- (NSString *)prefix {
    return @"unknown"; // <-- subclass me.
}

// make osx coordinate system behave like iOS
- (BOOL)isFlipped {
    return YES;
}

@end
