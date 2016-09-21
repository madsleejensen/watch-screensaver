//
//  WatchScreensaverView.m
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 15/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <Masonry/View+MASAdditions.h>
#import <QuartzCore/QuartzCore.h>
#import "MJScreenSaverView.h"
#import "MJPreferencesViewController.h"
#import "MJWatchView.h"
#import "MJColors.h"
#import "MJModels.h"
#import "MJPreferences.h"
#import "MJDigitalXLargeWatchView.h"
#import "MJImageLoader.h"
#import "AFHTTPRequestOperationManager.h"

#define SCREENSAVER_VERSION 2

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
    [self setupFonts];

    self.animationTimeInterval = 1/30.0;
    self.wantsLayer = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onPreferencesChanged:) name:@"watch.preferences.changed" object:nil];

    [self onPreferencesChanged:nil];
    [self setupUpdateBadge];
}

// we need to load fonts manually: http://stackoverflow.com/questions/10141655/embedding-a-custom-font-in-a-screensaver
- (void)setupFonts {
    NSURL *url = [[NSBundle bundleForClass:[self class]] URLForResource:@"SF-UI-Display-Regular" withExtension:@"otf"];
    CTFontManagerRegisterFontsForURL((__bridge CFURLRef) url, kCTFontManagerScopeProcess, nil);
}

- (void)setupUpdateBadge {
    NSImageView *updateBadgeImageView = [[NSImageView alloc] init];
    updateBadgeImageView.wantsLayer = YES;
    updateBadgeImageView.image = [MJImageLoader imageNamed:@"update_available"];
    updateBadgeImageView.hidden = self.isPreview;
    updateBadgeImageView.layer.opacity = 0.0f;
    [self addSubview:updateBadgeImageView];

    [updateBadgeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat ratio = 45.0f / 207.0f;

        make.width.equalTo(@207.0f);
        make.height.equalTo(updateBadgeImageView.mas_width).multipliedBy(ratio);
        make.left.equalTo(self).with.offset(30.0f);
        make.bottom.equalTo(self).with.offset(-30.0f);
    }];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    [manager GET:@"http://www.rasmusnielsen.dk/applewatch-version.json" parameters:nil success:^(AFHTTPRequestOperation *operation, NSDictionary *response) {
        NSInteger version = [response[@"version"] intValue];

        if (SCREENSAVER_VERSION < version) {
            // new version available-
            CABasicAnimation *fadeIn = [CABasicAnimation animationWithKeyPath:@"opacity"];
            fadeIn.fromValue = @0.0f;
            fadeIn.toValue = @1.0f;
            fadeIn.duration = 1.5f;
            fadeIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            fadeIn.fillMode = kCAFillModeForwards;
            fadeIn.removedOnCompletion = NO;
            [updateBadgeImageView.layer addAnimation:fadeIn forKey:@"fadeIn"];
        }

    } failure:nil];
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
            CGFloat size = roundf(self.frame.size.width * 0.26f);

            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            make.width.equalTo(@(size));
            make.height.equalTo(@(size));

//            make.width.equalTo(self.mas_width).multipliedBy(0.25f);
//            make.height.equalTo(view.mas_width);
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
