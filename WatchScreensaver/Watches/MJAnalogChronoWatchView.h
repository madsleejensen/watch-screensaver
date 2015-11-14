//
// Created by Mads Lee Jensen on 05/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>
#import "MJAnalogWatchView.h"

@interface MJAnalogChronoWatchView : MJAnalogWatchView

@property (nonatomic, strong) NSTextField *dateTextField;
@property (nonatomic, strong) NSImageView *secondMiniHandImageView;
@property (nonatomic, strong) NSImageView *miniHandImageView;

@end