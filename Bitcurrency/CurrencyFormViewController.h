//
//  CurrencyFormViewController.h
//  Bitcurrency
//
//  Created by Mathew Wong on 4/24/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "XLFormViewController.h"
#import "XLForm.h"
#import "Chameleon.h"

@interface CurrencyFormViewController : XLFormViewController <XLFormDescriptorDelegate>
@property (nonatomic) float amount;
-(id)initWithBTCamount:(float)btcAmount;
@end
