//
// Created by Mads Lee Jensen on 15/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "MJImageLoader.h"
#import "MJScreenSaverView.h"

@implementation MJImageLoader {

}

+ (NSImage *)imageNamed:(NSString *)name {
    NSBundle * saverBundle = [NSBundle bundleForClass:[MJScreenSaverView class]];
    NSString * imagePath = [saverBundle pathForResource:name ofType: @"png"];
    NSImage * image = [[NSImage alloc] initWithContentsOfFile:imagePath];

    return image;
}

@end