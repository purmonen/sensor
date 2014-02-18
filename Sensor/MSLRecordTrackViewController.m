//
//  MSLRecordTrackViewController.m
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "MSLRecordTrackViewController.h"
#import "MSLAccelerometerHandler.h"

@interface MSLRecordTrackViewController ()


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property MSLAccelerometerHandler *handler;
@property NSTimer *timer;
@property NSDate *startTime;
@property (weak, nonatomic) IBOutlet UILabel *accelerationDataLabel;
@property BOOL isRunning;
@property (weak, nonatomic) IBOutlet UIButton *startButton;

- (IBAction)start:(UIButton *)sender;

@end

@implementation MSLRecordTrackViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.isRunning = NO;
    self.startTime = [NSDate date];
    self.handler = [MSLAccelerometerHandler initWithInterval:2];
}


- (void)updateTimeLabel:(NSTimer *)timer {
    int interval = -(int)[self.startTime timeIntervalSinceNow];
    int seconds = interval % 60;
    int minutes = (interval / 60) % 60;
    int hour = interval / (60*60);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d", hour, minutes, seconds];
    
    NSMutableArray *data = [self.handler getData];

    if (![data count]) {
        NSLog(@"NO DATA");
        return;
    }
    CMAccelerometerData *accData = (CMAccelerometerData *)[data lastObject];
    CMAcceleration acc = accData.acceleration;
    
    self.accelerationDataLabel.text = [NSString stringWithFormat:@"X: %.3f, Y: %.3f, Z: %.3f", acc.x, acc.y, acc.z];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)start:(UIButton *)sender {
    if (!self.isRunning) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimeLabel:) userInfo:nil repeats:YES];
        self.startTime = [NSDate date];
        [self.timer fire];
        [self.handler start];
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
    } else {
    	[self.timer invalidate];
        self.timer = nil;
    	[self.handler stop];
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    self.isRunning = !self.isRunning;
}


@end
