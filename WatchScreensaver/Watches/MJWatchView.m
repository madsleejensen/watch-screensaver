//
// Created by Mads Lee Jensen on 12/11/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJWatchView.h"
#import <QuartzCore/QuartzCore.h>

@implementation MJWatchView {

}

- (instancetype)initWithPrimaryColor:(NSColor *)primaryColor {
    self = [super init];
    if (self) {
        self.calendar = [NSCalendar currentCalendar];
        self.primaryColor = primaryColor;
        self.wantsLayer = YES;
        self.layer.opacity = 0.0f;

        [self setupView];
        [self setupConstraints];
    }

    return self;
}

- (void)setupView {
    // override in sub classes
}

- (void)setupConstraints {
    // override in sub classes
}

- (void)onTick {
    // override in sub classes
}

- (void)animateIn:(BOOL)preview {
    CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeIn.fromValue = @0.0f;
    fadeIn.toValue = @1.0f;
    fadeIn.duration = preview ? 1.5f : 4.0f;
    fadeIn.beginTime = CACurrentMediaTime() + (preview ? 0.0f : 0.1f);
    fadeIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    fadeIn.fillMode = kCAFillModeForwards;
    fadeIn.removedOnCompletion = NO;
    [self.layer addAnimation:fadeIn forKey:@"fadeIn"];
}

@end