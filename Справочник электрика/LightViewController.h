//
//  LightViewController.h
//  Справочник электрика
//
//  Created by Admin on 28.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface LightViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *typeOfSpaceTableView;
@property (weak, nonatomic) IBOutlet UITableView *typeOfLightTableView;
@property (weak, nonatomic) IBOutlet UITableView *coefStockTableView;
@property (weak, nonatomic) IBOutlet UITableView *countLightTableView;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UIView *topInfoView;
@property (weak, nonatomic) IBOutlet UIPickerView *enterValuePickerView;
@property (weak, nonatomic) IBOutlet UIView *enterValueView;

@end
