//
//  MJColors.m
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 20/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJColors.h"
#import "MJColor.h"

#define UIColorFromRGB(rgbValue) [NSColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@implementation MJColors {
    NSArray *_colors;
}

+(instancetype)sharedInstance {
    static MJColors *instance;
    static dispatch_once_t token = 0;
    dispatch_once(&token, ^{
        instance = [[MJColors alloc] init];
    });
    
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _colors = @[
            [MJColor newColor:@"White" color:UIColorFromRGB(0xffffff)],
            [MJColor newColor:@"Red" color:UIColorFromRGB(0xff041f)],
            [MJColor newColor:@"Orange" color:UIColorFromRGB(0xff5129)],
            [MJColor newColor:@"Light Orange" color:UIColorFromRGB(0xff9700)],
            [MJColor newColor:@"Yellow" color:UIColorFromRGB(0xFFEC2D)],
            [MJColor newColor:@"Green" color:UIColorFromRGB(0x49e400)],
            [MJColor newColor:@"Turquoise" color:UIColorFromRGB(0x81d6cd)],
            [MJColor newColor:@"Light Blue" color:UIColorFromRGB(0x00c6df)],
            [MJColor newColor:@"Blue" color:UIColorFromRGB(0x00b7ff)],
            [MJColor newColor:@"Midnight Blue" color:UIColorFromRGB(0x4b85c3)],
            [MJColor newColor:@"Purple" color:UIColorFromRGB(0xa47cfa)],
            [MJColor newColor:@"Lavender" color:UIColorFromRGB(0xbc9ba8)],
            [MJColor newColor:@"Pink" color:UIColorFromRGB(0xff5864)],
            [MJColor newColor:@"Vintage Rose" color:UIColorFromRGB(0xffada6)],
            [MJColor newColor:@"Walnut" color:UIColorFromRGB(0xbf8762)],
            [MJColor newColor:@"Stone" color:UIColorFromRGB(0xb89a80)],
            [MJColor newColor:@"Antique White" color:UIColorFromRGB(0xdfb793)]
        ];
    }
    
    return self;
}

-(NSArray *)colorNames {
    NSMutableArray *names = [NSMutableArray new];
    for (MJColor *color in _colors) {
        [names addObject:color.name];
    }
    
    return names;
}

-(NSColor *)colorByName:(NSString *)name {
    for (MJColor *color in _colors) {
        if ([name isEqualToString:color.name]) {
            return color.color;
        }
    }
    
    return nil;
}

@end
