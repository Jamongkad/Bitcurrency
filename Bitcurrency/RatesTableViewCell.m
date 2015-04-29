//
//  RatesTableViewCell.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/27/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "RatesTableViewCell.h"

@implementation RatesTableViewCell

@synthesize currencyLabel, currencyRate, bitcoinRate, bitcoinAmount;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
       
        currencyLabel = [[UILabel alloc] init];
        currencyRate  = [[UILabel alloc] init];
        bitcoinRate   = [[UILabel alloc] init];
        bitcoinAmount = [[UILabel alloc] init];
        
        [self.contentView addSubview:currencyLabel];
        [self.contentView addSubview:currencyRate];
        [self.contentView addSubview:bitcoinAmount];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [currencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(currencyRate.mas_top);
    }];
    
    [bitcoinAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    [currencyRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currencyLabel.mas_bottom);
        make.left.equalTo(currencyLabel);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end