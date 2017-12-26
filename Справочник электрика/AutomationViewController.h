//
//  ViewController.h
//  Справочник электрика
//
//  Created by Admin on 13.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <iAd/iAd.h>
#import "MKStoreManager.h"

@interface AutomationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ADBannerViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *automationTableView;
@property (strong, nonatomic) ADBannerView *UIiAD;

@end

