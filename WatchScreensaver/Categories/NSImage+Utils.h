//
// Created by Mads Lee Jensen on 09/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface NSImage (Utils)

- (NSImage *)resizeToSize:(CGSize)size;
- (NSImage *)resizeToSize:(CGSize)size tint:(NSColor *)tint;
- (NSImage *)tint:(NSColor *)tint;

@end