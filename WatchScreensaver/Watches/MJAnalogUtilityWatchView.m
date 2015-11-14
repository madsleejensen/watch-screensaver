//
// Created by Mads Lee Jensen on 05/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJAnalogUtilityWatchView.h"
#import "View+MASAdditions.h"
#import "MASConstraintMaker.h"

@implementation MJAnalogUtilityWatchView {
    NSDateFormatter *_dateFormatter;
    NSUInteger _frameNumber;
}

- (void)setupView {
    [super setupView];

    _dateFormatter = [[NSDateFormatter alloc] init];
    _dateFormatter.dateFormat = @"dd";

    self.dateLabel = [NSTextField new];
    self.dateLabel.bezeled = NO;
    self.dateLabel.drawsBackground = NO;
    self.dateLabel.editable = NO;
    self.dateLabel.textColor = self.primaryColor;
    [self addSubview:self.dateLabel positioned:NSWindowAbove relativeTo:self.backgroundImageView];
}

- (void)setupConstraints {
    [super setupConstraints];

    [self.dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).multipliedBy(0.8f);
    }];
}

- (void)setFrame:(NSRect)frame {
    [super setFrame:frame];
    
    self.dateLabel.font = [NSFont fontWithName:@"SFUIDisplay-Regular" size:self.frame.size.width * 0.08f];
}

- (void)onTimeChanged:(double)hour minute:(double)minute second:(double)second {
    [super onTimeChanged:hour minute:minute second:second];

    if (_frameNumber % 60 == 0) {
        NSString *date = [[_dateFormatter stringFromDate:[NSDate date]] uppercaseString];
        self.dateLabel.stringValue = date;
    }

    _frameNumber++;
}

- (NSString *)prefix {
    return @"utility";
}

@end