//
//  MSLAccelerometerHandler.h
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>

@interface MSLAccelerometerHandler : NSObject

-(void)start;
-(void)stop;
-(NSMutableArray *)getData;

+(MSLAccelerometerHandler *)initWithInterval:(double)interval;

@end
