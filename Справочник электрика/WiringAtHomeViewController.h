//
//  WiringAtHomeViewController.h
//  Электрика
//
//  Created by Admin on 19.10.15.
//  Copyright © 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface WiringAtHomeViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *wiringAtHomeWebView;

@end
