//
//  WatchScreensaverView.m
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 15/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import "MJScreenSaverView.h"
#import "MJPreferencesViewController.h"
#import "MJWatchView.h"
#import "MJColors.h"
#import "MJModels.h"
#import "MJPreferences.h"
#import "MJDigitalXLargeWatchView.h"

@implementation MJScreenSaverView {
    MJPreferencesViewController *preferencesViewController;
}

- (instancetype)initWithFrame:(NSRect)frame isPreview:(BOOL)isPreview
{
    self = [super initWithFrame:frame isPreview:isPreview];
    if (self) {
        [self commonInit];
    }

    return self;
}

- (void)commonInit {
    self.animationTimeInterval = 1/30.0;
    self.wantsLayer = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPreferencesChanged:) name:@"watch.preferences.changed" object:nil];

    [self onPreferencesChanged:nil];
}

- (void)onPreferencesChanged:(NSNotification *)notification {
    MJPreferences *preferences = notification.object != nil ? notification.object : [MJPreferences new];

    Class modelClass = [[MJModels sharedInstance] classByModelName:preferences.modelName];;
    NSColor *color = [[MJColors sharedInstance] colorByName:preferences.colorName];

    MJWatchView *view = [[modelClass alloc] initWithPrimaryColor:color];
    self.watchView = view;
}

- (void)setWatchView:(MJWatchView *)view {
    if (_watchView) {
        [self.watchView removeFromSuperview];
    }

    view.hidden = YES;
    [self addSubview:view];

    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if ([view isKindOfClass:[MJDigitalXLargeWatchView class]]) {
            make.edges.equalTo(self);
        }
        else {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(self.mas_width).multipliedBy(0.25f);
            make.height.equalTo(view.mas_width);
        }
    }];

    // for some reason, the rotations are not reflected on the "initial" event loop.
    // to workaround this we hide the view, and wait for one event loop.
    // i think it has something to do with layer's and transforms not being updated "instantly"
    dispatch_async(dispatch_get_main_queue(), ^{
        view.hidden = NO;
        [view onTick];

        [view animateIn:self.isPreview];
    });

    _watchView = view;
}

- (void)startAnimation
{
    [super startAnimation];
}

- (void)stopAnimation
{
    [super stopAnimation];
}

- (void)drawRect:(NSRect)rect
{
    [super drawRect:rect];
}

- (void)animateOneFrame
{
    [self.watchView onTick];
}

- (BOOL)hasConfigureSheet
{
    return YES;
}

- (NSWindow*)configureSheet
{
    preferencesViewController = [MJPreferencesViewController new]; // we need to keep a strong reference otherwise it will crash when calling (NSApp endSheet:...)
    [preferencesViewController loadWindow];

    return preferencesViewController.window;
}

@end
