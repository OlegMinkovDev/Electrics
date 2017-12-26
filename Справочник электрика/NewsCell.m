//
//  NewsCell.m
//  Электрика
//
//  Created by Admin on 07.08.15.
//  Copyright (c) 2015 Minkov Inc. All rights reserved.
//

#import "NewsCell.h"

@implementation NewsCell

@synthesize picturesImageView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    picturesImageView.contentMode = UIViewContentModeScaleToFill;
    // Configure the view for the selected state
}

@end
