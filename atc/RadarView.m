//
//  RadarView.m
//  atc
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "RadarView.h"

@implementation RadarView

- (void)awakeFromNib
{
    [_plane addObserver:self forKeyPath:@"x" options:0 context:nil];
    [_plane addObserver:self forKeyPath:@"y" options:0 context:nil];
    [_plane addObserver:self forKeyPath:@"heading" options:0 context:nil];
    [_plane addObserver:self forKeyPath:@"speed" options:0 context:nil];
}

- (BOOL)isFlipped
{
    return YES;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // map
    
    [[NSColor colorWithCalibratedWhite:0.95 alpha:1] set];
    NSRectFill(self.bounds);
    
    [[NSColor colorWithCalibratedWhite:0.8 alpha:1] setStroke];
    
    for(int i = 100; i < self.bounds.size.width; i += 100)
    {
        NSBezierPath *line = [NSBezierPath bezierPath];
        [line moveToPoint:NSMakePoint(i + 0.5, 0)];
        [line lineToPoint:NSMakePoint(i + 0.5, self.bounds.size.height)];
        line.lineWidth = 1;
        [line stroke];
    }

    for(int i = 100; i < self.bounds.size.height; i += 100)
    {
        NSBezierPath *line = [NSBezierPath bezierPath];
        [line moveToPoint:NSMakePoint(0, i + 0.5)];
        [line lineToPoint:NSMakePoint(self.bounds.size.width, i + 0.5)];
        line.lineWidth = 1;
        [line stroke];
    }
    
    // plane
    
    [[NSColor colorWithCalibratedHue:(_plane.altitude / 40.0) * 0.5 saturation:1 brightness:0.7 alpha:1] set];
    NSBezierPath *dot = [NSBezierPath bezierPathWithOvalInRect:NSMakeRect(_plane.x - 1, _plane.y - 1, 3, 3)];
    [dot fill];
    
    float angle = (_plane.heading - 90.0) / 360.0 * 2 * M_PI;
    NSBezierPath *direction = [NSBezierPath bezierPath];
    [direction moveToPoint:NSMakePoint(_plane.x, _plane.y)];
    [direction lineToPoint:NSMakePoint(_plane.x + _plane.speed * cos(angle), _plane.y + _plane.speed * sin(angle))];
    direction.lineWidth = 1;
    [direction stroke];
    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self setNeedsDisplay:YES];
}

@end
