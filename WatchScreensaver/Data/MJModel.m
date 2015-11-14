//
//  MJModel.m
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 20/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJModel.h"

@implementation MJModel

+ (MJModel *)newModel:(NSString *)modelName modelClass:(Class)modelClass {
    MJModel *instance = [MJModel new];
    instance.modelName = modelName;
    instance.modelClass = modelClass;
    return instance;
}

@end
