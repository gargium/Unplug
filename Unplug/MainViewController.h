//
//  MainViewController.h
//  Unplug
//
//  Created by Gargium on 8/12/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface MainViewController : UIViewController {
    
    CMMotionManager *motionManager;
    NSOperationQueue *queue;
}
@property (weak, nonatomic) IBOutlet UILabel *xLab;
@property (weak, nonatomic) IBOutlet UILabel *yLab;
@property (weak, nonatomic) IBOutlet UILabel *zLab;

@end
