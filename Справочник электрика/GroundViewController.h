//
//  GroundViewController.h
//  Справочник электрика
//
//  Created by Admin on 21.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface GroundViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *groundWebView;

@end
