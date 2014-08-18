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
@synthesize xGyroLabel, yGyroLabel, zGyroLabel;
@synthesize phoneMovedLabel, scoreLabel1;

- (void) gameOver {
    
}

- (void) startGame {
    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.gyroUpdateInterval = 1.0/30.0; //Update at 30hz
    
    if(motionManager.gyroAvailable) {
        NSLog(@"Gyro Available");
        queue = [NSOperationQueue currentQueue];
        
        [motionManager startGyroUpdatesToQueue:queue
                                   withHandler:^(CMGyroData *gyroData, NSError *error) {
                                       CMRotationRate rotate = gyroData.rotationRate;
                                       xGyroLabel.text = [NSString stringWithFormat:@"%f",rotate.x];
                                       
                                       yGyroLabel.text = [NSString stringWithFormat:@"%f",
                                                          rotate.y];
                                       
                                       zGyroLabel.text = [NSString stringWithFormat:@"%f",
                                                          rotate.z];
                                       
                                       addedScore = 1;
                                       [self updateScore];
                                       
                                       if (rotate.x > .1 || rotate.x < -.1 ||
                                           rotate.y > .1 || rotate.y < -.1 ||
                                           rotate.z > .1 || rotate.z < -.1) {
                                           phoneMovedLabel.text = [NSString stringWithFormat:@"Phone moved!"];
                                           [motionManager stopGyroUpdates];
                                           [self gameOver];
                                       }
                                   }];
    }
}

- (void) updateScore {
    
    scoreNumber = scoreNumber + addedScore;
    addedScore = addedScore - 1;
    if (addedScore < 0) {
        addedScore = 0;
    }
    scoreLabel1.text = [NSString stringWithFormat:@"%i", scoreNumber/10];
    
}

- (void) gameDefaults {
    
    scoreNumber = 0;
    phoneMovedLabel.text = [NSString stringWithFormat:@"Phone has not been moved"];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self gameDefaults];
    [self startGame];
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
