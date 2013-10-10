//
//  AppDelegate.m
//  atc
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    _plane.x = 140;
    _plane.y = 220;
    _plane.speed = 6;
    _plane.speed_next = 6;
    _plane.heading = 30;
    _plane.heading_next = 270;
    _plane.altitude = 4;
    _plane.altitude_next = 4;
    
    [NSTimer scheduledTimerWithTimeInterval:0.033 target:_plane selector:@selector(calculateFrame) userInfo:nil repeats:YES];
}

@end
