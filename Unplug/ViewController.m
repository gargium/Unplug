//
//  ViewController.m
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//


//TODO LIST:
//- Add a timer
//- Add artwork for each view
//- Create one of those intro slideshow sequences
//- High score storage
//- Implement a way for the system to remember to only display the intro slideshow on the first launch
//- Implement a way for the system to show the whole slideshow all over again if the user presses the help button
//- Implement a help button ^^
//- Implement sensitivity levels ? (iffy on this one)
//- Add the start buttons on the first view in the storyboard to the intro slideshow views on first launch, and then display the start game button only on subsequent launches


#import "ViewController.h"

@interface ViewController ()

@end


@implementation ViewController
@synthesize xGyroLabel, yGyroLabel, zGyroLabel;
@synthesize phoneMovedLabel, scoreLabel1, twitterButton, restartGameButton, fbButton, dontTouchLabel, rememberLabel;

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    phoneMovedLabel.text = @"you moved the phone!";
    reasonforGameOver = @"iDevice has been moved!";
    [self gameOver];
    
}

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
    
    rememberLabel.hidden = YES;
    dontTouchLabel.hidden = YES;
    restartGameButton.hidden = NO;
    twitterButton.hidden = NO;
    fbButton.hidden = NO;
    UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:reasonforGameOver delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
    [gameOverAlert show];
    [motionManager stopGyroUpdates];
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
                                           reasonforGameOver = @"iDevice has been moved!";
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
    
    rememberLabel.hidden = NO;
    dontTouchLabel.hidden = NO;
    restartGameButton.hidden = YES;
    twitterButton.hidden = YES;
    fbButton.hidden = YES;
    adjustedScore = 0;
    phoneMovedLabel.text = [NSString stringWithFormat:@"Phone has not been moved"];
    UIImage *backgroundImageGold = [UIImage imageNamed:@"unplugBG1.png"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = backgroundImageGold;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
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
