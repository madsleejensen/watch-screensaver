//
//  WatchScreensaverView.h
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 15/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>

@class MJWatchView;

@interface MJScreenSaverView : ScreenSaverView

@property (nonatomic, strong) MJWatchView *watchView;

@end
