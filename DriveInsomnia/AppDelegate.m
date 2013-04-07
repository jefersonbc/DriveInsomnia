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
    
    // Name of hidden file with the name of the volume selected
    NSString *HiddenFile= [NSString stringWithFormat:@"%s%@%s%@", "/Volumes/", VolumeName, "/driveinsomnia_", VolumeName];
    
    NSString *LogedUsername= NSUserName();
    
    // Name of Launch Agent file with the name of the volume selected
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
        
        // Unload and load plist
        // Unload disk insomnia plist
        system("launchctl unload ~/Library/LaunchAgents/com.o2bits.driveinsomnia_Multivac.plist");
        // Load disk insomnia plist
        system("launchctl load ~/Library/LaunchAgents/com.o2bits.driveinsomnia_Multivac.plist");
        
        [self.LabelStatus setStringValue:[NSString stringWithFormat:@"%@%s", VolumeName, ", from now on, never goes to sleep. ;)"]];
    } else {
        NSLog(@"File does EXIST!");
        
        // File Permission 777
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setObject:[NSNumber numberWithInt:511] forKey:NSFilePosixPermissions];
        NSError *error1;
        [manager setAttributes:dict ofItemAtPath:HiddenFile error:&error1];
        // End File Permission 777
        
        [self.LabelStatus setStringValue:[NSString stringWithFormat:@"%@%s", VolumeName, ", from now on, never goes to sleep. ;)"]];
        
        NSMutableArray *books = [NSMutableArray new];
        int i;
        for (i = 0; i < 1; i++)
        {
            NSMutableDictionary *book = [NSMutableDictionary new];
            [books addObject:book];
            NSString *title = [NSString stringWithFormat:@"%s%@", "com.o2bits.driveinsomnia_", VolumeName];
            [book setObject:title forKey:@"Title"];
            NSString *arrayProgramArguments = [NSString stringWithFormat:@"%s%@", "com.o2bits.driveinsomnia_", VolumeName];
            [book setObject:arrayProgramArguments forKey:@"ProgramArguments"];
            [book setObject:[NSNumber numberWithBool:TRUE] forKey:@"RunAtLoad"];
            [book setObject:[NSNumber numberWithInt:60] forKey:@"StartInterval"];
        }
        
        // Name of Launch Agent file with the name of the volume selected
        NSString *LaunchAgentFileTest= [NSString stringWithFormat:@"%s%@%s", "/Users/", LogedUsername, "/Library/LaunchAgents/test1.plist"];

        
        [manager createFileAtPath:LaunchAgentFileTest contents:nil attributes:nil];
        
        BOOL success = [books writeToFile:LaunchAgentFileTest atomically:NO];
        if (success == NO)
        {
            NSLog(@"failed saving the XML plist file");
        }
        
    }
}
@end
