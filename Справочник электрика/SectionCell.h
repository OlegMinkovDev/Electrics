//
//  SectionCell.h
//  Электрика
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SectionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sectionValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *minusLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UISlider *sectionSlider;

@end
