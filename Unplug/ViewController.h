//
//  ViewController.h
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

float addedScore;
int scoreNumber;

@interface ViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}

@property (weak, nonatomic) IBOutlet UIProgressView *xAccelBar;
@property (weak, nonatomic) IBOutlet UIProgressView *yAccelBar;
@property (weak, nonatomic) IBOutlet UIProgressView *zAccelBar;

@property (weak, nonatomic) IBOutlet UILabel *xAccelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yAccelLabel;
@property (weak, nonatomic) IBOutlet UILabel *zAccelLabel;

@property (weak, nonatomic) IBOutlet UIProgressView *xGyroBar;
@property (weak, nonatomic) IBOutlet UIProgressView *yGyroBar;
@property (weak, nonatomic) IBOutlet UIProgressView *zGyroBar;

@property (weak, nonatomic) IBOutlet UILabel *xGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGyroLabel;

@property (weak, nonatomic) IBOutlet UILabel *xMagnetLabel;
@property (weak, nonatomic) IBOutlet UILabel *yMagnetLabel;
@property (weak, nonatomic) IBOutlet UILabel *zMagnetLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalMagnetLabel;

@property (weak, nonatomic) IBOutlet UILabel *phoneMovedLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;

-(void) updateScore;

@end
