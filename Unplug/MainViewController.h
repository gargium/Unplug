//
//  MainViewController.h
//  Unplug
//
//  Created by Gargium on 8/20/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

int highScoreNumber;

@interface MainViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;

- (BOOL) prefersStatusBarHidden;

@end
