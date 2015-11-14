//
//  MJPreferencesViewController.m
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 15/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import "MJPreferencesViewController.h"
#import "MJColors.h"
#import "MJModels.h"
#import "MJPreferences.h"

@implementation MJPreferencesViewController {
    MJPreferences *_preferences;
}

-(void)awakeFromNib {
    _preferences = [MJPreferences new];

    [self.stylePopUpButton removeAllItems];
    [self.modelPopUpButton removeAllItems];

    NSArray *colorNames = [[MJColors sharedInstance] colorNames];
    [self.stylePopUpButton addItemsWithTitles:colorNames];
    [self.stylePopUpButton selectItemAtIndex:[colorNames indexOfObject:_preferences.colorName]];

    NSArray *modelNames = [[MJModels sharedInstance] modelNames];
    [self.modelPopUpButton addItemsWithTitles:modelNames];
    [self.modelPopUpButton selectItemAtIndex:[modelNames indexOfObject:_preferences.modelName]];
}

- (IBAction)selectModel:(id)sender {
    _preferences.modelName = self.modelPopUpButton.selectedItem.title;
}

- (IBAction)selectColor:(id)sender {
    _preferences.colorName = self.stylePopUpButton.selectedItem.title;
}

- (NSString *)windowNibName {
    return @"Preferences";
}

- (IBAction)close:(id)sender {
    [NSApp endSheet:self.window];
}

@end
