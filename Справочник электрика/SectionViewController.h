//
//  CalculatorsViewController.h
//  Справочник электрика
//
//  Created by Admin on 14.04.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UITableView *inputTable;
@property (weak, nonatomic) IBOutlet UITableView *outputTable;
@property (weak, nonatomic) IBOutlet UIPickerView *enterValuePickerView;
@property (weak, nonatomic) IBOutlet UIView *enterValueView;
@property (weak, nonatomic) IBOutlet UIView *infoView;

@end
