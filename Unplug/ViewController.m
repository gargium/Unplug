//
//  ViewController.m
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//


// Create a game over method

#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize xAccelBar, yAccelBar, zAccelBar, xAccelLabel, yAccelLabel, zAccelLabel;
@synthesize xGyroBar, yGyroBar, zGyroBar, xGyroLabel, yGyroLabel,
    zGyroLabel;
@synthesize phoneMovedLabel;

- (void)viewDidLoad
{
    
    phoneMovedLabel.text = [NSString stringWithFormat:@"Phone has not been moved"];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0/30.0; //Update at 10Hz
    
    if (motionManager.accelerometerAvailable) {
        NSLog(@"Accelerometer Available");
        queue = [NSOperationQueue currentQueue];
        
        [motionManager startAccelerometerUpdatesToQueue:queue
                withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
                    CMAcceleration acceleration = accelerometerData.acceleration;
                    xAccelLabel.text = [NSString stringWithFormat:@"%f", acceleration.x];
                    xAccelBar.progress = ABS(acceleration.x);
                    
                    yAccelLabel.text = [NSString stringWithFormat:@"%f", acceleration.y];
                    yAccelBar.progress = ABS(acceleration.y);
                    
                    zAccelLabel.text = [NSString stringWithFormat:@"%f", acceleration.z];
                    zAccelBar.progress = ABS(acceleration.z);
                    
                
//                    
//                    if (acceleration.x > .1 && acceleration.x < -.1) {
//                        phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
//                    }
//                    if (acceleration.y > .1 && acceleration.y < -.1) {
//                        phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
//                    }
//                    if (acceleration.z > .1 && acceleration.z < -.1) {
//                        phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
//                    }
                    
                    
                }];
    }
    
    motionManager.gyroUpdateInterval = 1.0/30.0; //Update every 1.2 seconds
        
    if(motionManager.gyroAvailable) {
        NSLog(@"Gyro Available");
        queue = [NSOperationQueue currentQueue];
            
        [motionManager startGyroUpdatesToQueue:queue
                withHandler:^(CMGyroData *gyroData, NSError *error) {
                    CMRotationRate rotate = gyroData.rotationRate;
                    xGyroLabel.text = [NSString stringWithFormat:@"%f",rotate.x];
                    xAccelBar.progress = ABS(rotate.x);
                    
                    yGyroLabel.text = [NSString stringWithFormat:@"%f",
                                       rotate.y];
                    yAccelBar.progress = ABS(rotate.y);
                    
                    zGyroLabel.text = [NSString stringWithFormat:@"%f",
                                       rotate.z];
                    zAccelBar.progress = ABS(rotate.z);
                    
                    if (rotate.x > .1 || rotate.x < -.1) {
                        phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
                        [motionManager stopGyroUpdates];
                    }
                    if (rotate.y > .1 || rotate.y < -.1) {
                        phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
                        [motionManager stopGyroUpdates];
                    }
                    if (rotate.z > .1 || rotate.z < -.1) {
                        phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
                        [motionManager stopGyroUpdates];
                    }

                    
                }];
    }
    
    motionManager.magnetometerUpdateInterval = 1.0/30.0; //update at 10 hz
    if (motionManager.magnetometerAvailable) {
        queue = [NSOperationQueue currentQueue];
        
        [motionManager startMagnetometerUpdatesToQueue:queue withHandler:^(CMMagnetometerData *magnetometerData, NSError *error) {
            
            CMMagneticField field = magnetometerData.magneticField;
            self.xMagnetLabel.text = [NSString stringWithFormat:@"%f", field.x];
            self.yMagnetLabel.text = [NSString stringWithFormat:@"%f", field.y];
            self.zMagnetLabel.text = [NSString stringWithFormat:@"%f", field.z];
            self.totalMagnetLabel.text = [NSString stringWithFormat:@"%f", sqrt(field.x * field.x + field.y * field.y + field.z * field.z)];
        }];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
