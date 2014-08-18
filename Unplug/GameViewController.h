//
//  GameViewController.h
//  Unplug
//
//  Created by Gargium on 8/15/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

int addedScore;
int scoreNumber;

@interface GameViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *q;
    
}

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *alertLabel;

-(void)updateScore;


@end
