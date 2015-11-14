//
// Created by Mads Lee Jensen on 11/11/15.
// Copyright (c) 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJColor;
@class MJModel;

@interface MJPreferences : NSObject

- (void)setColorName:(NSString *)colorName;
- (NSString *)colorName;

- (void)setModelName:(NSString *)modelName;
- (NSString *)modelName;

@end