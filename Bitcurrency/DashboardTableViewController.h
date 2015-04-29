//
//  DashboardTableViewController.h
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Chameleon.h"
#import "UIColor+HTMLColors.h"
#import <AFNetworking/AFNetworking.h>

#import "DatabaseController.h"

#import "RatesTableViewCell.h"

@interface DashboardTableViewController : UITableViewController
@property (nonatomic, strong) DatabaseController *dbc;
@end
