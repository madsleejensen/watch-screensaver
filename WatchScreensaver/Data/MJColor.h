//
// Created by Mads Lee Jensen on 08/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface MJColor : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSColor *color;

+ (MJColor *)newColor:(NSString *)name color:(NSColor *)color;

@end