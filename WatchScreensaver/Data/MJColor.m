//
// Created by Mads Lee Jensen on 08/10/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJColor.h"


@implementation MJColor {

}

+ (MJColor *)newColor:(NSString *)name color:(NSColor *)color {
    MJColor *instance = [MJColor new];
    instance.name = name;
    instance.color = color;

    return instance;
}

@end