//
// Created by Mads Lee Jensen on 11/11/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <ScreenSaver/ScreenSaver.h>
#import "MJPreferences.h"

@implementation MJPreferences {
    NSUserDefaults *_defaults;
}

-(instancetype)init {
    self = [super init];
    if (self) {
        _defaults = [ScreenSaverDefaults defaultsForModuleWithName:@"dk.mads-lee.watch"];
    }

    return self;
}

- (void)setColorName:(NSString *)colorName {
    [_defaults setObject:colorName forKey:@"watchColor"];
    [self save];
}

- (NSString *)colorName {
    NSString *colorName = [_defaults stringForKey:@"watchColor"];
    return colorName != nil ? colorName : @"Orange";
}

- (void)setModelName:(NSString *)modelName {
    [_defaults setObject:modelName forKey:@"watchModel"];
    [self save];
}

- (NSString *)modelName {
    NSString *modelName = [_defaults stringForKey:@"watchModel"];
    return modelName != nil ? modelName : @"Simple";
}

- (void)save {
    [_defaults synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"watch.preferences.changed" object:self];
}

@end