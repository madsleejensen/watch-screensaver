//
// Created by Mads Lee Jensen on 05/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJAnalogChronoWatchView.h"
#import "View+MASAdditions.h"
#import "MASConstraintMaker.h"
#import "NSImage+Utils.h"
#import "MJImageLoader.h"

@implementation MJAnalogChronoWatchView {
    NSDateFormatter *_dateFormatter;
    NSUInteger _frameNumber;
}

- (void)setupView {
    [super setupView];

    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateFormat = @"EEE  d";
    
    self.dateTextField = [[NSTextField alloc] init];
    self.dateTextField.editable = NO;
    self.dateTextField.drawsBackground = NO;
    self.dateTextField.bezeled = NO;
    [self addSubview:self.dateTextField positioned:NSWindowAbove relativeTo:self.backgroundImageView];

    self.secondMiniHandImageView = [[NSImageView alloc] init];
    [self addSubview:self.secondMiniHandImageView positioned:NSWindowAbove relativeTo:self.backgroundImageView];

    self.miniHandImageView = [[NSImageView alloc] init];
    [self addSubview:self.miniHandImageView positioned:NSWindowAbove relativeTo:self.backgroundImageView];
}

- (void)setupConstraints {
    [super setupConstraints];

    [self.dateTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).multipliedBy(0.98f);
        make.right.equalTo(self).multipliedBy(0.84f);
    }];
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    
    self.hourHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.hourHandImageView.frame), CGRectGetMidY(self.hourHandImageView.frame));
    self.hourHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    self.minuteHandImageView.layer.position = CGPointMake(CGRectGetMidX(self.minuteHandImageView.frame), CGRectGetMidY(self.minuteHandImageView.frame));
    self.minuteHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
    
    CGFloat smallSize = roundf(self.frame.size.width * 0.28f);;

    self.secondMiniHandImageView.image = [[MJImageLoader imageNamed:@"chrono_small_secondhand"] resizeToSize:CGSizeMake(smallSize, smallSize)];
    self.secondMiniHandImageView.frame = CGRectMake(roundf((self.frame.size.width - smallSize)/2.0f), roundf(self.frame.size.height * 0.545f), smallSize, smallSize);
    self.secondMiniHandImageView.layer.position = CGPointMake(roundf(CGRectGetMidX(self.secondMiniHandImageView.frame)), roundf(CGRectGetMidY(self.secondMiniHandImageView.frame)));
    self.secondMiniHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);

    self.miniHandImageView.image = [[MJImageLoader imageNamed:@"chrono_small_secondhand_orange"] resizeToSize:CGSizeMake(smallSize, smallSize) tint:self.primaryColor];
    self.miniHandImageView.frame = CGRectMake(roundf((self.frame.size.width - smallSize)/2.0f), roundf(self.frame.size.height * 0.175f), smallSize, smallSize);
    self.miniHandImageView.layer.position = CGPointMake(roundf(CGRectGetMidX(self.miniHandImageView.frame)), roundf(CGRectGetMidY(self.miniHandImageView.frame)));
    self.miniHandImageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);

    self.dateTextField.font = [NSFont fontWithName:@"SFUIDisplay-Regular" size:roundf(self.frame.size.width * 0.065f)];
}

- (void)onTimeChanged:(double)hour minute:(double)minute second:(double)second {
    double hourAngle = 360.0f * (hour / 12.0f);
    double minuteAngle = 360.0f * (minute / 60.0f);
    double secondAngle = 360.0f * (second / 60.0f);

    self.hourHandImageView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(hourAngle), 0, 0, 1.0f);
    self.minuteHandImageView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(minuteAngle), 0, 0, 1.0f);
    self.secondMiniHandImageView.layer.transform = CATransform3DMakeRotation(DEGREES_TO_RADIANS(secondAngle), 0, 0, 1.0f);

    if (_frameNumber % 60 == 0) {
        NSString *date = [[_dateFormatter stringFromDate:[NSDate date]] uppercaseString];
        NSMutableAttributedString *dateString = [[NSMutableAttributedString alloc] initWithString:date];
        [dateString addAttribute:NSForegroundColorAttributeName value:[NSColor whiteColor] range:NSMakeRange(0, date.length)];
        [dateString addAttribute:NSForegroundColorAttributeName value:self.primaryColor range:NSMakeRange(date.length - 2, 2)];
        self.dateTextField.attributedStringValue = dateString;
    }

    _frameNumber++;
}

- (NSString *)prefix {
    return @"chrono";
}

@end