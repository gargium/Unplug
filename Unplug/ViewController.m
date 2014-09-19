//
//  ViewController.m
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import "ViewController.h"
#import "Foundation/Foundation.h"

int highScoreNumber;


@interface ViewController ()

@end


@implementation ViewController
@synthesize twitterButton,
            restartGameButton,
            fbButton,
            dontTouchLabel,
            rememberLabel,
            reasonForGameOver,
            stopwatchLabel,
            secondsLabel,
            gameOverLabel,
            reasonForGameOverLabel;

// scoreLabel1;

@synthesize timeToPostToNetwork, mainMenuButton;


- (NSTimer *)createTimer {
    return [NSTimer scheduledTimerWithTimeInterval:1.0
                                            target:self
                                          selector:@selector(timerTicked:)
                                          userInfo:nil
                                           repeats:YES];
}

- (void)timerTicked:(NSTimer *)timer {
    
    _elapsedTime++;
    self.stopwatchLabel.text = [self formattedTime:_elapsedTime];
    
    
}

- (NSString *)formattedTime:(int)totalSeconds
{
    
//    int seconds = totalSeconds % 60;
//    int minutes = (totalSeconds / 60) % 60;
//    int hours = totalSeconds / 3600;
    
    int seconds = _elapsedTime % 60;
    int minutes = (_elapsedTime / 60);
    int hours = _elapsedTime / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d:%02d", hours, minutes, seconds];


}

-(BOOL) prefersStatusBarHidden {
    
    return YES;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    reasonForGameOverLabel.text = @"You touched your device!";
    reasonForGameOver = @"iDevice has been touched!";
    [self gameOver];
    
}

- (IBAction)restartGameButton:(id)sender {
    
    if (_myTimer) {
        [_myTimer invalidate];
        _myTimer = [self createTimer];
    }
    
    _elapsedTime = 0;
    self.stopwatchLabel.text = [self formattedTime:_elapsedTime];
    
    [self gameDefaults];
    [self startGame];
}

- (IBAction)postToTwitter:(id)sender {
    
    //math to check if the time elapsed should be reported in seconds, minutes, or hours
    
    int seconds = _elapsedTime % 60;
    int minutes = (_elapsedTime / 60);
    int hours = _elapsedTime / 3600;
    
//    int score = [scoreLabel1.text integerValue];
    if (_elapsedTime < 60) {
        timeToPostToNetwork = [NSString stringWithFormat:@"I lasted %i seconds without my iDevice! Find out how long you can last with Unplug Pro on the App Store!", seconds];
    }
    else if (_elapsedTime > 59 && _elapsedTime < 3600) {
        timeToPostToNetwork = [NSString stringWithFormat:@"I lasted %i minutes and %i seconds without my iDevice! Find out how long you can last with Unplug Pro on the App Store!", minutes, seconds];
    }
    else if (_elapsedTime > 3599) {
        timeToPostToNetwork = [NSString stringWithFormat:@"I lasted %i hours, %i minutes, and %i seconds without my iDevice! Find out how long you can last with Unplug Pro on the App Store!", hours, minutes, seconds];
    }
    
    //  Checking if Twitter account is available on device
    
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter]) {
        
        mySLComposerSheet = [[SLComposeViewController alloc] init]; // Initiate Social Controller
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter]; //Specify that we want Twitter,
        //  not an alternate Social Network
        [mySLComposerSheet setInitialText:timeToPostToNetwork]; //Default text that will show up in the box
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
    
    //math to check if the time elapsed should be reported in seconds, minutes, or hours
    
    int seconds = _elapsedTime % 60;
    int minutes = (_elapsedTime / 60);
    int hours = _elapsedTime / 3600;
    
    //    int score = [scoreLabel1.text integerValue];
    if (_elapsedTime < 60) {
        timeToPostToNetwork = [NSString stringWithFormat:@"I lasted %i seconds without my iDevice! Find out how long you can last with Unplug Pro on the App Store!", seconds];
    }
    else if (_elapsedTime > 59 && _elapsedTime < 3600) {
        timeToPostToNetwork = [NSString stringWithFormat:@"I lasted %i minutes and %i seconds without my iDevice! Find out how long you can last with Unplug Pro on the App Store!", minutes, seconds];
    }
    else if (_elapsedTime > 3599) {
        timeToPostToNetwork = [NSString stringWithFormat:@"I lasted %i hours, %i minutes, and %i seconds without my iDevice! Find out how long you can last with Unplug Pro on the App Store!", hours, minutes, seconds];
    }

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        mySLComposerSheet = [[SLComposeViewController alloc] init];
        mySLComposerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        //[mySLComposerSheet setInitialText:[NSString stringWithFormat:@"I just scored %i points and lasted %i seconds before touching or moving my iDevice!" , adjustedScore, _elapsedTime, mySLComposerSheet.serviceType]];
        [mySLComposerSheet setInitialText:timeToPostToNetwork];
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
    
//    if (scoreNumber > highScoreNumber) {
//        highScoreNumber = scoreNumber;
//        [[NSUserDefaults standardUserDefaults] setInteger:highScoreNumber forKey:@"HighScoreSaved"];
    
      if (_elapsedTime > highScoreNumber) {
            highScoreNumber = _elapsedTime;
            [[NSUserDefaults standardUserDefaults] setInteger:highScoreNumber forKey:@"HighScoreSaved"];
    }

    
    [_myTimer invalidate];
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    mainMenuButton.hidden = NO;
    gameOverLabel.hidden = NO;
    reasonForGameOverLabel.hidden = NO;
    rememberLabel.hidden = YES;
    dontTouchLabel.hidden = YES;
    restartGameButton.hidden = NO;
    twitterButton.hidden = NO;
    fbButton.hidden = NO;
//    UIAlertView *gameOverAlert = [[UIAlertView alloc] initWithTitle:@"Game Over!" message:reasonForGameOver delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil];
//    [gameOverAlert show];
    [motionManager stopGyroUpdates];
    
}

- (void) startGame {
    
    if (!_elapsedTime) {
        _elapsedTime = 0 ;
    }
    
    if (!_myTimer) {
        _myTimer = [self createTimer];
    }
    

    
    motionManager = [[CMMotionManager alloc] init];
    motionManager.gyroUpdateInterval = 1.0/30.0; //Update at 30hz
    
    if(motionManager.gyroAvailable) {
        NSLog(@"Gyro Available");
        queue = [NSOperationQueue currentQueue];
        
        [motionManager startGyroUpdatesToQueue:queue
                                   withHandler:^(CMGyroData *gyroData, NSError *error) {
                                       CMRotationRate rotate = gyroData.rotationRate;
                                       if (_elapsedTime > 3599) {
                                           self.secondsLabel.text = @"hours";
                                       }
                                       else if (_elapsedTime > 59) {
                                           self.secondsLabel.text = @"minutes";
                                       }
                                       else {
                                           self.secondsLabel.text = @"seconds";
                                       }
                                       
//                                       addedScore = 1;
//                                       [self updateScore];
                                       

                                       if (rotate.x > .3 || rotate.x < -.3 ||
                                           rotate.y > .3 || rotate.y < -.3 ||
                                           rotate.z > .3 || rotate.z < -.3) {
                                           reasonForGameOverLabel.text = [NSString stringWithFormat:@"iDevice has been moved!"];
                                           reasonForGameOver = @"iDevice has been moved!";
                                           [self gameOver];
                                       }
                                   }];
        
    }
}

//- (void) updateScore {
//    
////    scoreNumber = scoreNumber + addedScore;
////    addedScore = addedScore - 1;
////    if (addedScore < 0) {
////        addedScore = 0;
////    }
////    adjustedScore = scoreNumber / M_PI;
////    scoreLabel1.text = [NSString stringWithFormat:@"%i", adjustedScore];
//    
////ADD A SCORENUMBER = ELAPSED TIME THING HERE. CAN'T DO MUCH UNTIL I HAVE AN ACTUAL IDEVICE TO PLAY WITH
//    
//}

- (void) gameDefaults {
    
    mainMenuButton.hidden = YES;
    gameOverLabel.hidden = YES;
    reasonForGameOverLabel.hidden = YES;
    secondsLabel.text = @"seconds";
    rememberLabel.hidden = NO;
    dontTouchLabel.hidden = NO;
    restartGameButton.hidden = YES;
    twitterButton.hidden = YES;
    fbButton.hidden = YES;
//    scoreNumber = 0;
//    phoneMovedLabel.text = [NSString stringWithFormat:@"Phone has not been moved"];
    UIImage *backgroundImageGold = [UIImage imageNamed:@"unplugBG1.png"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = backgroundImageGold;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
}

- (void)viewDidLoad
{
    UIAlertView *reminder = [[UIAlertView alloc] initWithTitle:@"Remember:"
                                                       message:@"Don't touch or move your device!"
                                                      delegate:nil
                                             cancelButtonTitle:@"Got it"
                                             otherButtonTitles:nil];
    
    highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    [reminder show];
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSInteger launchCount = [prefs integerForKey:@"launchCount"];
    if (launchCount >= 1) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Like or loathe this app?"
                                                        message:@"Rate us on the app store!"
                                                       delegate:nil
                                              cancelButtonTitle:@"No thanks"
                                              otherButtonTitles:@"Sure!", @"Remind me later",  nil];
        
        if (showRateUsAlert) {
            [alert show];
        }
    }
    

    [super viewDidLoad];
    [self gameDefaults];
    [self startGame];
   
}

-(void) alertView:(UIAlertView *) alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //remind me later button, so no action is necessary since the next time they open the app, the alert will pop up.
        //shows the alert for the next time
        
        
        //turn the boolean logic into an nsuser defaults thing -- reminder for next time.
        showRateUsAlert = YES;
        
        
    } else if (buttonIndex == 2) {
        //sure! button
        //when clicked, takes user to the app store to rate the app.
        
        showRateUsAlert = YES;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/unplug-pro/id911651752?ls=1&mt=8"]];
    
    } else if (buttonIndex == [alertView cancelButtonIndex]) {
        showRateUsAlert = NO;
    
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
