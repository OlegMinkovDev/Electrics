//
//  DiametrSectionViewController.h
//  Электрика
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "DiametrCell.h"
#import "SectionCell.h"

@interface DiametrSectionViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *diametrSectionTableView;

@end
