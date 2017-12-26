//
//  NewsViewController.h
//  Электрика
//
//  Created by Admin on 06.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>
#import "AppDelegate.h"
#import "MKStoreManager.h"
#import "NewsCell.h"
#import "DetailNewsViewController.h"

@interface NewsViewController : UIViewController <NSURLConnectionDelegate, ADBannerViewDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableData *_responseData;
}

@property (strong, nonatomic) ADBannerView *UIiAD;
@property (weak, nonatomic) IBOutlet UITableView *newsTableView;

@end
