//
//  MSLRecordTrackViewController.m
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "MSLRecordTrackViewController.h"
#import "MSLAccelerometerHandler.h"
#import "MSLGPSHandler.h"
#import "MSLTimer.h"


@interface MSLRecordTrackViewController ()


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property MSLAccelerometerHandler *accelerometerHandler;
@property MSLGPSHandler * gpsHandler;
@property MSLTimer *timer;
@property (weak, nonatomic) IBOutlet UILabel *accelerationDataLabel;
@property BOOL isRunning;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UITextView *textView;

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
    self.timer = [MSLTimer initWithBlock:^(NSString *timeDifference) {
        [self updateTimeLabel:timeDifference];
    }];
    self.accelerometerHandler = [MSLAccelerometerHandler initWithInterval:2];
    self.gpsHandler=[MSLGPSHandler initWithPrecision:2];
    [self.gpsHandler start];						
}


- (void)updateTimeLabel:(NSString *)timeDifference
{
    self.timeLabel.text = timeDifference;
    NSMutableArray *data = [self.accelerometerHandler getData];

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


- (IBAction)start:(UIButton *)sender
{
    if (!self.isRunning) {
        [self.timer start];
        [self.accelerometerHandler start];
    } else {
    	[self.timer stop];
    	[self.accelerometerHandler stop];
        
        self.textView.text = [self.accelerometerHandler getDataInCSV];
    }
    
    self.isRunning = !self.isRunning;
    [self.startButton setTitle:self.isRunning ? @"Stop" : @"Start" forState:UIControlStateNormal];

}

@end
