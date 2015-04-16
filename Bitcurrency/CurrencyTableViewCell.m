//
//  CurrencyTableViewCell.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/15/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "CurrencyTableViewCell.h"

@implementation CurrencyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
