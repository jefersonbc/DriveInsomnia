//
//  AppDelegate.m
//  DriveInsomnia
//
//  Created by Jeferson Brito on 05/04/13.
//  Copyright (c) 2013 O2Bits. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // initializing application
    [self.LabelStatus setStringValue:@"Status of sleep."];
    
    // Array with Volume names
    NSArray *AllVolumes= [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/Volumes" error:nil];
    
    // Add Volume names as items
    [self.VolumesCombo addItemsWithObjectValues:AllVolumes];
}

- (IBAction)VolumesCombo:(id)sender {
    [self.LabelStatus setStringValue:self.VolumesCombo.stringValue];
}

- (IBAction)ApplyInsomnia:(id)sender {
    // Volume Name selected on VolumesCombo
    NSString *VolumeName= self.VolumesCombo.stringValue;
    
    // Path of hidden file with the name of the volume selected
    NSString *HiddenFile= [NSString stringWithFormat:@"%s%@%s%@", "/Volumes/", VolumeName, "/driveinsomnia_", VolumeName];
    
    // Name of th logged User
    NSString *LogedUsername= NSUserName();
    
    // Path of Launch Agent file with the name of the volume selected
    NSString *LaunchAgentFile= [NSString stringWithFormat:@"%s%@%s%@%s", "/Users/", LogedUsername, "/Library/LaunchAgents/com.o2bits.driveinsomnia_", VolumeName, ".plist"];
    
    // Manager
    NSFileManager *manager;
    manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:HiddenFile]==NO) {
        // if file does NOT exist, create!
        NSLog(@"File does NOT exist!");
        
        // Create hidden file on disk
        [manager createFileAtPath:HiddenFile contents:nil attributes:nil];
        // Create disk insomnia plist file
        [manager createFileAtPath:LaunchAgentFile contents:nil attributes:nil];
        
        // File Permission 777
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:511] forKey:NSFilePosixPermissions];
        NSError *error1;
        [manager setAttributes:dict ofItemAtPath:HiddenFile error:&error1];
        // End File Permission 777
        
        // PList Content
        NSMutableDictionary *PlistContent = [NSMutableDictionary new];
        
        NSString *label = [NSString stringWithFormat:@"%s%@", "com.o2bits.driveinsomnia_", VolumeName];
        [PlistContent setObject:label forKey:@"Label"];
        
        NSArray *arrayProgramArguments= [NSArray arrayWithObjects:
                                         @"touch",
                                         @"-c",
                                         [NSString stringWithFormat:@"%s%@%s%@", "/Volumes/", VolumeName, "/driveinsomnia_", VolumeName],
                                         nil];
        [PlistContent setObject:arrayProgramArguments forKey:@"ProgramArguments"];
        
        [PlistContent setObject:[NSNumber numberWithBool:TRUE] forKey:@"RunAtLoad"];
        [PlistContent setObject:[NSNumber numberWithInt:60] forKey:@"StartInterval"];
        // End PList Content
        
        // Write the PList Content in the PList File
        BOOL success = [PlistContent writeToFile:LaunchAgentFile atomically:NO];
        if (success == NO)
        {
            NSLog(@"failed saving the XML plist file");
        }
        
        // Unload and load plist
        // Unload disk insomnia plist
        NSTask *setLaunchAgentPathUnload = [NSTask new];
        [setLaunchAgentPathUnload setLaunchPath:@"/usr/bin/launchctl"];
        [setLaunchAgentPathUnload setArguments:[NSArray arrayWithObject:[NSString stringWithFormat:@"unload %@", LaunchAgentFile]]];
        [setLaunchAgentPathUnload launch];
        [setLaunchAgentPathUnload waitUntilExit];
        // Load disk insomnia plist
        NSTask *setLaunchAgentPathLoad = [NSTask new];
        [setLaunchAgentPathLoad setLaunchPath:@"/usr/bin/launchctl"];
        [setLaunchAgentPathLoad setArguments:[NSArray arrayWithObject:[NSString stringWithFormat:@"load %@", LaunchAgentFile]]];
        [setLaunchAgentPathLoad launch];
        [setLaunchAgentPathLoad waitUntilExit];
        // End Unload and load plist
        
        [self.LabelStatus setStringValue:[NSString stringWithFormat:@"%@%s", VolumeName, ", from now on, never goes to sleep. ;)"]];
        
    } else {
        NSLog(@"File does EXIST!");
        
        [self.LabelStatus setStringValue:[NSString stringWithFormat:@"%@%s", VolumeName, ", is already under the Insomnia's Power! ;)"]];
        
    }
}
@end
