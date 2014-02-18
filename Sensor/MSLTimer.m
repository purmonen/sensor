//
//  MSLTimer.m
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "MSLTimer.h"

@interface MSLTimer ()

@property NSDate *startTime;
@property NSTimer* timer;
@property (nonatomic, strong) void (^block)(NSString *);
@end

@implementation MSLTimer


+ (MSLTimer *)initWithBlock:(void (^)(NSString *))block {
	MSLTimer *timer = [[MSLTimer alloc] init];
    timer.block = block;
    return timer;
}

- (void)start
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(update:) userInfo:nil repeats:YES];
    self.startTime = [NSDate date];
    [self.timer fire];
}

- (void)update:(NSTimer *)timer
{
    self.block([self timeDifferenceString]);
}

- (void)stop
{
    [self.timer invalidate];
    self.timer = nil;
}

- (NSString *)timeDifferenceString
{
    int interval = -(int)[self.startTime timeIntervalSinceNow];
    int seconds = interval % 60;
    int minutes = (interval / 60) % 60;
    int hour = interval / (60*60);
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minutes, seconds];
}

@end
