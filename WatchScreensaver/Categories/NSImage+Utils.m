//
// Created by Mads Lee Jensen on 09/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import "NSImage+Utils.h"


@implementation NSImage (Utils)

- (NSImage *)resizeToSize:(CGSize)size {
    return [self resizeToSize:size tint:nil];
}

- (NSImage *)resizeToSize:(CGSize)size tint:(NSColor *)tint {
    NSImage *newImage = [[NSImage alloc] initWithSize:size];
    NSGraphicsContext *context = [NSGraphicsContext currentContext];
    [newImage lockFocus];
    context.imageInterpolation = NSImageInterpolationHigh;

    // resize
    NSRect targetRect = NSMakeRect(0, 0, size.width, size.height);
    [self drawInRect:targetRect fromRect:NSMakeRect(0, 0, self.size.width, self.size.height) operation:NSCompositeCopy fraction:1.0f];

    // tint
    if (tint) {
        [tint set];
        NSRectFillUsingOperation(targetRect, NSCompositeSourceAtop);
    }

    [newImage unlockFocus];

    return newImage;
}

- (NSImage *)tint:(NSColor *)tint {
    NSImage *newImage = [self copy];
    [newImage lockFocus];

    [tint set];
    NSRectFillUsingOperation(NSMakeRect(0, 0, newImage.size.width, newImage.size.height), NSCompositeSourceAtop);

    [newImage unlockFocus];
    return newImage;
}

@end