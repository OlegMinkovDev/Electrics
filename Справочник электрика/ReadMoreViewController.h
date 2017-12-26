//
//  ReadMoreViewController.h
//  Электрика
//
//  Created by Admin on 01.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ReadMoreViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *readMoreWebView;

@end
