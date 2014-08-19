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
@synthesize phoneMovedLabel, scoreLabel1, twitterButton, restartGameButton, fbButton;

- (IBAction)restartGameButton:(id)sender {
    
    [self gameDefaults];
    [self startGame];
}

- (IBAction)postToTwitter:(id)sender {
    
    //  Checking if Twitter account is available on device
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        mySLComposerSheet = [[SLComposeViewController alloc] init]; // Initiate Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Specify that we want Twitter,
        //  not an alternate Social Network
        
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"I just scored %i points and lasted %i seconds before touching or moving my iDevice!" , adjustedScore, timeElapsed, mySLComposerSheet.serviceType]]; //Default text that will show up in the box
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        
        //  BASIC ERROR MANAGEMENT:
        //  Returns a popup alert notifying the user whether the post was successful or if the action was cancelled
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitter" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];

}

- (IBAction)postToFacebook:(id)sender {
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        mySLComposerSheet = [[SLComposeViewController alloc] init];
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [mySLComposerSheet setInitialText:[NSString stringWithFormat:@"I just scored %i points and lasted %i seconds before touching or moving my iDevice!" , adjustedScore, timeElapsed, mySLComposerSheet.serviceType]];
        [self presentViewController:mySLComposerSheet animated:YES completion:nil];
    }
    
    [mySLComposerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
        NSString *output;
        switch (result) {
            case SLComposeViewControllerResultCancelled:
                output = @"Action Cancelled";
                break;
            case SLComposeViewControllerResultDone:
                output = @"Post Successful";
            default:
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Facebook" message:output delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }];

}
- (void) gameOver {
    
    restartGameButton.hidden = NO;
    twitterButton.hidden = NO;
    fbButton.hidden = NO;
    
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
    adjustedScore = scoreNumber / 7;
    scoreLabel1.text = [NSString stringWithFormat:@"%i", adjustedScore];
    
}

- (void) gameDefaults {
    
    
    restartGameButton.hidden = YES;
    twitterButton.hidden = YES;
    fbButton.hidden = YES;
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
