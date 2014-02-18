//
//  MSLViewController.m
//  Sensor
//
//  Created by Sami Purmonen on 2014-02-18.
//  Copyright (c) 2014 Sami Purmonen. All rights reserved.
//

#import "MSLViewController.h"
#import "MSLAccelerometerHandler.h"

@interface MSLViewController ()

@end

@implementation MSLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    MSLAccelerometerHandler *handler = [MSLAccelerometerHandler initWithInterval:2];
    [handler start];
    NSLog(@"HANDLER STARTED");
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
