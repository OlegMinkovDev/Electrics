//
//  TableOfFuse-linksViewController.h
//  Электрика
//
//  Created by Admin on 06.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface TableOfFuse_linksViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *tableOfFuseLinksWebView;

@end
