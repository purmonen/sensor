//
//  MSLTimer.h
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MSLTimer : NSObject

+ (MSLTimer *)initWithBlock:(void (^)(NSString *))block;
- (void)start;
- (void)stop;

@end
