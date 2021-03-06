//
//  RatesTableViewCell.h
//  Bitcurrency
//
//  Created by Mathew Wong on 4/27/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "TWRBorderedView.h"
#import "Chameleon.h"

@interface RatesTableViewCell : UITableViewCell {
    UILabel *currencyLabel;
    UILabel *currencyRate;
    UILabel *bitcoinAmount;
    UILabel *bitcoinFont;
    UILabel *equalSign;
    UIView *cellContainer;
    UIView *separator;
}

@property (nonatomic, strong) UILabel *currencyLabel;
@property (nonatomic, strong) UILabel *currencyRate;
@property (nonatomic, strong) UILabel *bitcoinAmount;

@end
