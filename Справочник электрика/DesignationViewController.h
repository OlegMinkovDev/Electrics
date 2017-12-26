//
//  DesignationViewController.h
//  Справочник электрика
//
//  Created by Admin on 15.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface DesignationViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *designationWebView;

@end
