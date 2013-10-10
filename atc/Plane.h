//
//  Plane.h
//  atc
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Plane : NSObject

@property (nonatomic) float x;
@property (nonatomic) float y;
@property (nonatomic) float heading;
@property (nonatomic) float speed;
@property (nonatomic) float altitude;

@property (nonatomic) float heading_next;
@property (nonatomic) float speed_next;
@property (nonatomic) float altitude_next;

- (void) calculateFrame;

@end
