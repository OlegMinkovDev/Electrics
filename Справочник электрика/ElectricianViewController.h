//
//  ElectricianViewController.h
//  Справочник электрика
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <iAd/iAd.h>
#import "MKStoreManager.h"

@interface ElectricianViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *electricanTableView;
@property (strong, nonatomic) ADBannerView *UIiAD;

@end
