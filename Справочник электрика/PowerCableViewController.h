//
//  PowerCableViewController.h
//  Справочник электрика
//
//  Created by Admin on 25.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PowerCableViewController : UIViewController <UIWebViewDelegate>

@property (strong, nonatomic) IBOutlet UIWebView *powerCableWebView;

@end
