//
//  RatesTableViewCell.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/27/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "RatesTableViewCell.h"

@implementation RatesTableViewCell

@synthesize currencyLabel, currencyRate, bitcoinAmount;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        float fontSize = 20.0;
        float smallFontSize = 13.0;
        
        bitcoinAmount = [[UILabel alloc] init];
        bitcoinFont   = [[UILabel alloc] init];
        currencyLabel = [[UILabel alloc] init];
        currencyRate  = [[UILabel alloc] init];
        
        equalSign = [[UILabel alloc] init];
        
        [bitcoinAmount setFont:[UIFont systemFontOfSize:fontSize]];
        [bitcoinFont setFont:[UIFont systemFontOfSize:smallFontSize]];
       
        [currencyRate setFont:[UIFont systemFontOfSize:fontSize]];
        [currencyLabel setFont:[UIFont systemFontOfSize:smallFontSize]];
        
        [bitcoinFont setTextColor:[UIColor lightTextColor]];
        [bitcoinFont setText:@"BTC"];
        
        [equalSign setTextColor:[UIColor lightTextColor]];
        [equalSign setText:@"="];
        [equalSign setFont:[UIFont systemFontOfSize:50.0]];
        
        cellContainer = [[UIView alloc] init];
        [cellContainer addSubview:bitcoinAmount];
        [cellContainer addSubview:bitcoinFont];
        [cellContainer addSubview:currencyRate];
        [cellContainer addSubview:currencyLabel];
        [cellContainer addSubview:equalSign];
        
        separator = [[UIView alloc] init];
        [separator setBackgroundColor:[UIColor lightGrayColor]];
        [cellContainer addSubview:separator];
        
        [self.contentView addSubview:cellContainer];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    UIEdgeInsets padding = UIEdgeInsetsMake(14, 20, 10, 20);
    
    [equalSign mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView).offset(-5);
        make.centerX.equalTo(self.contentView);
    }];

    [cellContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(padding);
    }];
    
        [separator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom);
            make.left.equalTo(self.contentView.mas_left);
            make.right.equalTo(self.contentView.mas_right);
            make.height.equalTo(@1);
        }];
    
    [bitcoinAmount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cellContainer.mas_top);
        make.left.equalTo(cellContainer.mas_left);
    }];
    
    [bitcoinFont mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(bitcoinAmount.mas_bottom);
        make.centerX.equalTo(bitcoinAmount);
    }];
    
    [currencyRate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(cellContainer.mas_right);
        make.top.equalTo(cellContainer.mas_top);
    }];
    
    [currencyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currencyRate.mas_bottom);
        make.centerX.equalTo(currencyRate);
    }];
}

- (void)setNeedsLayout {
    [super setNeedsLayout];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end