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

int addedScore;
int scoreNumber;
int adjustedScore;
int timeElapsed;

@interface ViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
    SLComposeViewController *mySLComposerSheet;

}


@property (weak, nonatomic) IBOutlet UILabel *xGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneMovedLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;
@property (weak, nonatomic) IBOutlet UIButton *restartGameButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterButton;
@property (weak, nonatomic) IBOutlet UIButton *fbButton;

-(void) updateScore;
-(void) gameOver;
-(void) startGame;
-(void) gameDefaults;
- (IBAction)restartGameButton:(id)sender;
- (IBAction)postToTwitter:(id)sender;
- (IBAction)postToFacebook:(id)sender;

@end
