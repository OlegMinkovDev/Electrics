//
//  FrequencyCell.h
//  Справочник электрика
//
//  Created by Admin on 03.05.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FrequencyCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *HertzLabel;
@property (weak, nonatomic) IBOutlet UISlider *FrequencySlider;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UILabel *minusLabel;

@end
