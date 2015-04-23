//
//  RootViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
@property (nonatomic, strong) DashboardTableViewController *dtvc;
@property (nonatomic, strong) NSNumber *toggle;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.toggle = [NSNumber numberWithInt:0];
    
    self.title = @"Rates";
    UIBarButtonItem *addCurrency = [[UIBarButtonItem alloc] initWithTitle:@"Add Currency" style:UIBarButtonItemStylePlain target:self action:@selector(addCurrency:)];
    [addCurrency setTintColor:[UIColor whiteColor]];
    
    UIBarButtonItem *edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(edit:)];
    [edit setTintColor:[UIColor whiteColor]];
    
    [self.navigationItem setRightBarButtonItem:addCurrency];
    [self.navigationItem setLeftBarButtonItem:edit];
    
    [self.view setBackgroundColor:[UIColor flatBlueColor]];
    self.dtvc = [[DashboardTableViewController alloc] init];
    [self addChildViewController:self.dtvc];
    [self.view addSubview:self.dtvc.view];

    [self.dtvc.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void)addCurrency:(id)sender {
    CurrencyTableViewController *ctv = [[CurrencyTableViewController alloc] init];
    [self.navigationController pushViewController:ctv animated:YES];
}

- (void)edit:(id)sender {
    if([self.toggle isEqualToNumber:[NSNumber numberWithInt:0]]) {
        self.toggle = [NSNumber numberWithInt:1];
        [self.dtvc.tableView setEditing:YES animated:YES];
    } else {
        self.toggle = [NSNumber numberWithInt:0];
        [self.dtvc.tableView setEditing:NO animated:YES];
    }
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
