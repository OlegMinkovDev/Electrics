//
//  CalculateSpeedViewController.h
//  Справочник электрика
//
//  Created by Admin on 03.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FrequencyCell.h"
#import "CountCell.h"
#import "SpeedCell.h"
#import "AppDelegate.h"

@interface CalculateSpeedViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *calculateSpeedTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@end
