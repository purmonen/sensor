//
//  MSLGPSHandler.m
//  Sensor
//
//  Created by Paul on 21/02/14.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//
#import <CoreLocation/CoreLocation.h>
#import "MSLGPSHandler.h"


@interface MSLGPSHandler ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property NSMutableArray *data;

@end

@implementation MSLGPSHandler
+(MSLGPSHandler *)initWithPrecision:(double)meters {
    
    
    MSLGPSHandler *handler = [[MSLGPSHandler alloc] init];
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.distanceFilter = meters;
    handler.locationManager = manager;
    NSMutableArray *data = [[NSMutableArray alloc] init];
    handler.data = data;
    manager.delegate = (id)handler;
    return handler;
}

//-(void)handleAccelerationData:(CMAccelerometerData *)accelerationData {
//    [self.data addObject:accelerationData];
//}

-(void)start {
    [self.locationManager startUpdatingLocation];
}
-(void)stop {
    [self.locationManager stopUpdatingLocation];
}

-(NSMutableArray *)getData {
    return self.data;
}

// Delegate method from the CLLocationManagerDelegate protocol.
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations {
    // If it's a relatively recent event, turn off updates to save power.
    CLLocation* location = [locations lastObject];
    NSDate* eventDate = location.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0) {
        // If the event is recent, do something with it.
        NSLog(@"latitude %+.6f, longitude %+.6f\n",
              location.coordinate.latitude,
              location.coordinate.longitude);
    }
}

@end
