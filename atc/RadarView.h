//
//  RadarView.h
//  atc
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "Plane.h"

@interface RadarView : NSView

@property (nonatomic, weak) IBOutlet Plane *plane;

@end
