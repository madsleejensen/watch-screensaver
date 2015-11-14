//
//  MJColors.h
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 20/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface MJColors : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)colorNames;
- (NSColor *)colorByName:(NSString *)name;

@end
