//
//  GameViewController.m
//  Unplug
//
//  Created by Gargium on 8/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import "GameViewController.h"


@interface GameViewController ()

@end

@implementation GameViewController

@synthesize scoreLabel, alertLabel;

- (void) updateScore {
    
    scoreNumber = scoreNumber + addedScore;
    addedScore = addedScore - 1;
    if (addedScore < 0) {
        addedScore = 0;
    }
    scoreLabel.text = [NSString stringWithFormat:@"%i", scoreNumber];

    
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //add this code to be triggered by Easy,Medium,Hard buttons later on
    //for now it should be triggered by default whenever the view is loaded up
    //start up motionmanagers to determine phone's position and whether or not it is being moved
    motionManager = [[CMMotionManager alloc] init];
    motionManager.gyroUpdateInterval = 1.0/30.0;
    
    
    __block NSTimer *tUpdate;
    NSTimeInterval tiCallRate = 1.0/30.0;
    
    
    if (motionManager.gyroAvailable) {
        NSLog(@"Gyro is Available");
        q = [NSOperationQueue currentQueue];
        
        [motionManager startGyroUpdatesToQueue:q
                                   withHandler:^(CMGyroData *gyroData, NSError *error) {
                                       CMRotationRate rotate = gyroData.rotationRate;
                                                if (rotate.x < .1 || rotate.x > -.1 ||
                                                    rotate.y < .1 || rotate.y > -.1 ||
                                                    rotate.z < .1 || rotate.z > -.1) {
                                                    
                                                    tUpdate = [NSTimer scheduledTimerWithTimeInterval:tiCallRate
                                                                                               target:self
                                                                                             selector:@selector(updateScore)
                                                                                             userInfo:nil
                                                                                              repeats:YES];
                                                    
                                                    [motionManager stopGyroUpdates];
                                                    
                                                    alertLabel.text = [NSString stringWithFormat:@"Dont touch the phone!"];
                                                    
                                                }
                                                
                                                else {
//                                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over!"
//                                                                                                    message:@"You moved the phone!"
//                                                                                                   delegate:self
//                                                                                          cancelButtonTitle:@"Ok"
//                                                                                          otherButtonTitles:nil, nil];
//                                                    [alert show];
                                                    
                                                    alertLabel.text = [NSString stringWithFormat:@"oops! you moved the phone!"];
                                                    
                                                    
                                                }
                                            }];
    }
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
