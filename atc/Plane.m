//
//  Plane.m
//  atc
//
//  Created by Radosław Pietruszewski on 10.10.2013.
//  Copyright (c) 2013 Radosław Pietruszewski. All rights reserved.
//

#import "Plane.h"

float angleDirection(float current, float next)
{
    if(current >= 0 && current < 180)
    {
        return (next > current && next <= current + 180.0) ? 1.0 : -1.0;
    }
    else
    {
        return (next >= current - 180.0 && next < current) ? -1.0 : 1.0;
    }
}

@implementation Plane

- (void)calculateFrame
{
    const float acceleration = 1.0;
    
    if(_speed != _speed_next)
    {
        bool accelerating = (_speed_next > _speed);
        self.speed += (accelerating ? 1.0 : -1.0) * acceleration * 0.033;
        
        if((accelerating && _speed > _speed_next) || (!accelerating && _speed < _speed_next))
        {
            self.speed = _speed_next;
        }
    }
    
    const float heading_omega = 30.0;
    
    if(_heading != _heading_next)
    {
        float direction = angleDirection(_heading, _heading_next);
        
        self.heading += direction * heading_omega * 0.033;
        self.heading = fmod(_heading + 360, 360.0); // enforce bottom and top boundaries
        
        float direction_after = angleDirection(_heading, _heading_next);
        if((direction > 0 && direction_after < 0) || (direction < 0 && direction_after > 0))
        {
            self.heading = _heading_next;
        }
    }
    
    
    float angle = (_heading - 90.0) / 360.0 * 2 * M_PI;
    float speed_xy = _speed;
    
    const float climbing_angle = 10.0 / 360.0 * 2 * M_PI;
    
    if(_altitude != _altitude_next)
    {
        bool climbing = (_altitude_next > _altitude);
        float z_angle = (climbing ? 1.0 : -1.0) * climbing_angle;
        
        float speed_z = _speed * sin(z_angle);
        speed_xy = _speed * cos(z_angle);
        
        self.altitude += speed_z * 0.033;
        
        if((climbing && _altitude > _altitude_next) || (!climbing && _altitude < _altitude_next))
        {
            self.altitude = self.altitude_next;
        }
    }
    
    self.x += speed_xy * 0.033 * cos(angle);
    self.y += speed_xy * 0.033 * sin(angle);
}

@end
