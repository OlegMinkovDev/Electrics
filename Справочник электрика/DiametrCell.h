//
//  DiametrCell.h
//  Электрика
//
//  Created by Admin on 09.10.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiametrCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *diametrValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *minusLabel;
@property (weak, nonatomic) IBOutlet UILabel *plusLabel;
@property (weak, nonatomic) IBOutlet UISlider *diametrSlider;

@end
