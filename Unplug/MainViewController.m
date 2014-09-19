//
//  MainViewController.m
//  Unplug
//
//  Created by Gargium on 8/20/14.
//  Copyright (c) 2014 Gargium Interactive. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize highScoreLabel;

-(BOOL) prefersStatusBarHidden {
    
    return YES;
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
    highScoreNumber = [[NSUserDefaults standardUserDefaults] integerForKey:@"HighScoreSaved"];
    
    int highScoreSeconds = highScoreNumber % 60;
    int highScoreMinutes = (highScoreNumber / 60);
    int highScoreHours = highScoreNumber / 3600;
    
    if (highScoreNumber < 61) {
        highScoreLabel.text = [NSString stringWithFormat:@"High Score: %i seconds", highScoreNumber];
    }
    else if (highScoreNumber > 60 && highScoreNumber < 3600) {
        highScoreLabel.text = [NSString stringWithFormat:@"High Score: %i minutes, %i seconds", highScoreMinutes, highScoreSeconds];
    }
    else if (highScoreNumber > 3600) {
        highScoreLabel.text = [NSString stringWithFormat:@"High Score: %i hours, %i minutes, %i seconds", highScoreHours, highScoreMinutes, highScoreSeconds];
    }

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImage *backgroundImageGold = [UIImage imageNamed:@"s_Main.png"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = backgroundImageGold;
    [self.view insertSubview:backgroundImageView atIndex:0];
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
