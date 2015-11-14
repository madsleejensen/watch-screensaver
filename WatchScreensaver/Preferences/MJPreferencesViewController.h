//
//  MJPreferencesViewController.h
//  WatchScreensaver
//
//  Created by Mads Lee Jensen on 15/10/15.
//  Copyright © 2015 Mads Lee Jensen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface MJPreferencesViewController : NSWindowController

@property (weak) IBOutlet NSPopUpButton *modelPopUpButton;
@property (weak) IBOutlet NSPopUpButton *stylePopUpButton;

@end
