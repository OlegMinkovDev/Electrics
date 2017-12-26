//
//  CalculatorsViewController.h
//  Справочник электрика
//
//  Created by Admin on 25.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "MKStoreManager.h"

@interface CalculatorsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,
ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *calculatorsTableView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (strong, nonatomic) ADBannerView *UIiAD;

@end
