//
// Created by Mads Lee Jensen on 05/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MJDigitalXLargeWatchView.h"

@implementation MJDigitalXLargeWatchView {
    NSTimer *_timer;
}

- (instancetype)initWithPrimaryColor:(NSColor *)primaryColor {
    self = [super initWithPrimaryColor:primaryColor];
    if (self) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(updateTime) userInfo:nil repeats:YES];
        [self updateTime];
    }

    return self;
}

- (void)onTick {
    // we use nstimer instead.
}

- (void)updateTime {
    NSTimeInterval timeInterval = [NSDate timeIntervalSinceReferenceDate];
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:timeInterval];

    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit) fromDate:date];

    self.topDigitsLabel.stringValue = [NSString stringWithFormat:@"%02d", (self.shouldUse24HourFormat ? components.hour : components.hour % 12)];
    self.bottomDigitsLabel.stringValue = [NSString stringWithFormat:@"%02d", components.minute];

    CABasicAnimation *fadeOut = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeOut.fromValue = @0.5f;
    fadeOut.toValue = @1.0f;
    fadeOut.beginTime = 0.0f;
    fadeOut.duration = 0.25f;
    fadeOut.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];

    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @1.0f;
    fadeIn.toValue = @0.5f;
    fadeIn.beginTime = 0.25f;
    fadeIn.duration = 0.75f;

    CAAnimationGroup *pulse = [CAAnimationGroup animation];
    pulse.duration = 1.0f;
    pulse.animations = @[fadeOut, fadeIn];

    [self.separatorsLabel.layer addAnimation:pulse forKey:@"pulse"];
    [self layout];
}

// http://stackoverflow.com/questions/7448360/detect-if-time-format-is-in-12hr-or-24hr-format
- (BOOL)shouldUse24HourFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    [formatter setDateStyle:NSDateFormatterNoStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSRange amRange = [dateString rangeOfString:[formatter AMSymbol]];
    NSRange pmRange = [dateString rangeOfString:[formatter PMSymbol]];

    return (amRange.location == NSNotFound && pmRange.location == NSNotFound);
}

- (void)setupView {
    self.topDigitsLabel = [[NSTextField alloc] init];
    self.topDigitsLabel.bezeled = NO;
    self.topDigitsLabel.editable = NO;
    self.topDigitsLabel.drawsBackground = NO;
    self.topDigitsLabel.textColor = self.primaryColor;
    self.topDigitsLabel.alignment = NSTextAlignmentRight;
    [self addSubview:self.topDigitsLabel];

    self.separatorsLabel = [[NSTextField alloc] init];
    self.separatorsLabel.bezeled = NO;
    self.separatorsLabel.editable = NO;
    self.separatorsLabel.drawsBackground = NO;
    self.separatorsLabel.textColor = self.primaryColor;
    self.separatorsLabel.stringValue = @":";
    [self addSubview:self.separatorsLabel];

    self.bottomDigitsLabel = [[NSTextField alloc] init];
    self.bottomDigitsLabel.bezeled = NO;
    self.bottomDigitsLabel.editable = NO;
    self.bottomDigitsLabel.drawsBackground = NO;
    self.bottomDigitsLabel.textColor = self.primaryColor;
    self.bottomDigitsLabel.alignment = NSTextAlignmentRight;
    [self addSubview:self.bottomDigitsLabel];
}

- (void)layout {
    [super layout];

     // update font-size to match new size;
    CGFloat fontSize = self.frame.size.height/1.65f;
    self.topDigitsLabel.font = [NSFont fontWithName:@"SFUIDisplay-Regular" size:fontSize];
    self.separatorsLabel.font = [NSFont fontWithName:@"SFUIDisplay-Regular" size:fontSize * 0.9f];
    self.bottomDigitsLabel.font = [NSFont fontWithName:@"SFUIDisplay-Regular" size:fontSize];
    [self.topDigitsLabel sizeToFit];
    [self.bottomDigitsLabel sizeToFit];
    [self.separatorsLabel sizeToFit];

    NSRect topFrame = self.topDigitsLabel.frame;
    NSRect bottomFrame = self.bottomDigitsLabel.frame;
    NSRect separatorFrame = self.separatorsLabel.frame;

    CGFloat maxWidth = fmaxf(topFrame.size.width, bottomFrame.size.width);
    CGFloat offsetX = (self.frame.size.width - maxWidth) / 2.0f;
    CGFloat deltaBottomWidth = maxWidth - bottomFrame.size.width;

    topFrame.origin.x = offsetX;
    topFrame.origin.y = -(self.topDigitsLabel.frame.size.height * 0.15f);
    topFrame.size.width = maxWidth;

    bottomFrame.origin.x = offsetX;
    bottomFrame.origin.y = self.bottomDigitsLabel.frame.size.height * 0.52f;
    bottomFrame.size.width = maxWidth;

    separatorFrame.origin.y = bottomFrame.origin.y;
    separatorFrame.origin.x = ((bottomFrame.origin.x + deltaBottomWidth) - separatorFrame.size.width);

    self.topDigitsLabel.frame = topFrame;
    self.bottomDigitsLabel.frame = bottomFrame;
    self.separatorsLabel.frame = separatorFrame;
}

// make osx coordinate system behave like iOS
- (BOOL)isFlipped {
    return YES;
}

- (void)dealloc {
    [_timer invalidate];
}

@end