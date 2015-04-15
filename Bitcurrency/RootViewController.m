//
//  RootViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Rates";
    UIBarButtonItem *addCurrency = [[UIBarButtonItem alloc] initWithTitle:@"Add Currency" style:UIBarButtonItemStylePlain target:self action:@selector(addCurrency:)];
    [addCurrency setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:addCurrency];
    
    UIColor *gradientBG = [UIColor colorWithGradientStyle:UIGradientStyleTopToBottom
                                                withFrame:self.view.frame
                                                andColors:@[[UIColor flatBlueColor], [UIColor lightGrayColor]]];
    [self.view setBackgroundColor:gradientBG];
    DashboardTableViewController *dtvc = [[DashboardTableViewController alloc] init];
    [self addChildViewController:dtvc];
    [self.view addSubview:dtvc.view];

    [dtvc.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addCurrency:(id)sender {
    CurrencyTableViewController *ctv = [[CurrencyTableViewController alloc] init];
    [self.navigationController pushViewController:ctv animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
