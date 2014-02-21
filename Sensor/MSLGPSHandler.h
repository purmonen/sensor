//
//  MSLGPSHandler.h
//  Sensor
//
//  Created by Paul on 21/02/14.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLGPSHandler : NSObject

- (void)start;
- (void)stop;
- (NSMutableArray *)getData;

+ (MSLGPSHandler *)initWithPrecision:(double)meters;
@end
