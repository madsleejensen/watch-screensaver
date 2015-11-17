//
//  MJModels.m
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 20/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJModels.h"
#import "MJModel.h"
#import "MJAnalogSimpleWatchView.h"
#import "MJAnalogChronoWatchView.h"
#import "MJAnalogNormalWatchView.h"
#import "MJAnalogUtilityWatchView.h"
#import "MJDigitalXLargeWatchView.h"

@implementation MJModels {
    NSArray *_models;
}

+ (instancetype)sharedInstance {
    static MJModels *instance;
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        instance = [self new];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _models = @[
            [MJModel newModel:@"Simple" modelClass:[MJAnalogSimpleWatchView class]],
            [MJModel newModel:@"Chronograph" modelClass:[MJAnalogChronoWatchView class]],
            [MJModel newModel:@"Normal" modelClass:[MJAnalogNormalWatchView class]],
            [MJModel newModel:@"Utility" modelClass:[MJAnalogUtilityWatchView class]],
            [MJModel newModel:@"X-LARGE" modelClass:[MJDigitalXLargeWatchView class]],
        ];
    }
    
    return self;
}

-(NSArray *)modelNames {
    NSMutableArray *names = [NSMutableArray new];
    for (MJModel *model in _models) {
        [names addObject:model.modelName];
    }
    
    return names;
}

-(Class)classByModelName:(NSString *)modelName {
    for (MJModel *model in _models) {
        if ([modelName isEqualToString:model.modelName]) {
            return model.modelClass;
        }
    }
    
    return nil;
}


@end
