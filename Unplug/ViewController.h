//
//  ViewController.h
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <CoreMotion/CoreMotion.h>
#import <AudioToolbox/AudioServices.h>
#import "MainViewController.h"

//int addedScore;
//int scoreNumber;
//int adjustedScore;

int timeElapsed;
int highScoreNumber;

//BOOL showRateUsAlert;

@interface ViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
    SLComposeViewController *mySLComposerSheet;

}


//@property (weak, nonatomic) IBOutlet UILabel *phoneMovedLabel;
//@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UIButton *restartGameButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;
@property (weak, nonatomic) IBOutlet UILabel *rememberLabel;
@property (weak, nonatomic) IBOutlet UILabel *dontTouchLabel;
@property (weak, nonatomic) NSString *reasonForGameOver;
@property (weak, nonatomic) IBOutlet UILabel *stopwatchLabel;
@property (weak, nonatomic) NSTimer *myTimer;
@property int elapsedTime;
@property (weak, nonatomic) IBOutlet UILabel *secondsLabel;
@property (weak, nonatomic) IBOutlet UILabel *gameOverLabel;
@property (weak, nonatomic) IBOutlet UILabel *reasonForGameOverLabel;
@property (weak, nonatomic) NSString *timeToPostToNetwork;
@property (weak, nonatomic) IBOutlet UIButton *mainMenuButton;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void) updateScore;
-(void) gameOver;
-(void) startGame;
-(void) gameDefaults;


- (IBAction)restartGameButton:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;
-(BOOL) prefersStatusBarHidden;

@end
