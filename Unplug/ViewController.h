//
//  ViewController.h
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

int addedScore;
int scoreNumber;

@interface ViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}


@property (weak, nonatomic) IBOutlet UILabel *xGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneMovedLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel1;

-(void) updateScore;

@end
