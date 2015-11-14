//
//  MJModels.h
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 20/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MJModel;

@interface MJModels : NSObject

+ (instancetype)sharedInstance;

- (NSArray *)modelNames;
- (Class)classByModelName:(NSString *)modelName;

@end
