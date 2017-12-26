//
//  AboutProjectViewController.h
//  Справочник электрика
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MKStoreManager.h"

@interface AboutProjectViewController : UIViewController <UIWebViewDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
@property (weak, nonatomic) IBOutlet UIButton *removeiIdButton;

- (IBAction)RemoveiAdBanner:(id)sender;
- (IBAction)RateApp:(id)sender;
-(void)hideLockView;

@property (weak, nonatomic) IBOutlet UIWebView *aboutProjectWebView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *aboutProjectSegmentedControl;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UIView *lockView;
@property (assign, nonatomic) BOOL isInternetConnection;

@end
