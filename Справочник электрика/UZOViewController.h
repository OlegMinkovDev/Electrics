//
//  UZOViewController.h
//  Электрика
//
//  Created by Admin on 04.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface UZOViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *uzoTableView;
@property (weak, nonatomic) IBOutlet UIView *topInfoView;

@end
