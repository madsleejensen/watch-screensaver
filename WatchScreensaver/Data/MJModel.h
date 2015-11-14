//
//  MJModel.h
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 20/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJModel : NSObject

@property (strong, nonatomic) NSString *modelName;
@property (assign, nonatomic) Class modelClass;

+ (MJModel *)newModel:(NSString *)modelName modelClass:(Class)modelClass;

@end
