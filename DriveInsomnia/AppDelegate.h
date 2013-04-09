//
//  AppDelegate.h
//  DriveInsomnia
//
//  Created by Jeferson Brito on 05/04/13.
//  Copyright (c) 2013 O2Bits. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (weak) IBOutlet NSTextField *LabelStatus;

@property (weak) IBOutlet NSComboBox *VolumesCombo;
- (IBAction)VolumesCombo:(id)sender;

- (IBAction)ApplyInsomnia:(id)sender;

- (IBAction)RemoveInsomnia:(id)sender;

@end
