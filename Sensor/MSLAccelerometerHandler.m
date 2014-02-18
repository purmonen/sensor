//
//  MSLAccelerometerHandler.m
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "MSLAccelerometerHandler.h"



@interface MSLAccelerometerHandler ()

@property (strong, nonatomic) CMMotionManager *motionManager;
@property NSMutableArray *data;

@end
@implementation MSLAccelerometerHandler

+(MSLAccelerometerHandler *)initWithInterval:(double)interval {
    MSLAccelerometerHandler *handler = [[MSLAccelerometerHandler alloc] init];
    CMMotionManager *manager = [[CMMotionManager alloc] init];
    manager.accelerometerUpdateInterval = interval;
    handler.motionManager = manager;
    NSMutableArray *data = [[NSMutableArray alloc] init];
    handler.data = data;
    return handler;
}

-(void)handleAccelerationData:(CMAccelerometerData *)accelerationData {
    [self.data addObject:accelerationData];
}

-(void)start {
    [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                             withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                 [self handleAccelerationData:accelerometerData];
                                                 if(error) {
                                                     NSLog(@"%@", error);
                                                 }
                                             }];
}

-(void)stop {
    [self.motionManager stopAccelerometerUpdates];
}

-(NSMutableArray *)getData {
    return self.data;
}

- (NSString *)getDataInCSV {
    NSMutableString *csv = [NSMutableString stringWithString:@""];
    int i;
    for (i = 0; i < [self.data count]; i++) {
        CMAccelerometerData *data = (CMAccelerometerData *)[self.data objectAtIndex:i];
        CMAcceleration acc = data.acceleration;
        [csv appendString:[NSString stringWithFormat:@",%f,%f,%f,%f", acc.x, acc.y, acc.z, data.timestamp]];
    }
	return [csv substringFromIndex:1];
}

@end
