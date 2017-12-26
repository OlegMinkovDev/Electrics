//
//  GeneratorActsViewController.h
//  Электрика
//
//  Created by Admin on 31.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface GeneratorActsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *topInfoView;
@property (weak, nonatomic) IBOutlet UITableView *typeTableView;
@property (weak, nonatomic) IBOutlet UITableView *viewTableView;
@property (weak, nonatomic) IBOutlet UITableView *docTableView;
@property (weak, nonatomic) IBOutlet UIPickerView *enterValuePickerView;
@property (weak, nonatomic) IBOutlet UIButton *openButton;
- (IBAction)OpenClick:(id)sender;


@end
