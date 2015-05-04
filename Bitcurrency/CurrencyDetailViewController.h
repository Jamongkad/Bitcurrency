//
//  CurrencyDetailViewController.h
//  Bitcurrency
//
//  Created by Mathew Wong on 4/23/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DatabaseController.h"
#import "Chameleon.h"
#import "Masonry.h"
#import "CurrencyFormViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>

@interface CurrencyDetailViewController : UIViewController
@property (nonatomic, strong) NSDictionary *currencyData;
@property (nonatomic, strong) DatabaseController *dbc;
@end
