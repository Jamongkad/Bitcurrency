//
//  CurrencyDetailViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/23/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "CurrencyDetailViewController.h"

@interface CurrencyDetailViewController ()

@end

@implementation CurrencyDetailViewController

@synthesize currencyData;

- (instancetype)init {
    if(self = [super init]) {
        self.dbc = [[DatabaseController alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *save = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(save:)];
    [save setTintColor:[UIColor whiteColor]];
    [self.navigationItem setRightBarButtonItem:save];
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
    [cancel setTintColor:[UIColor whiteColor]];
    [self.navigationItem setLeftBarButtonItem:cancel];
    [self.view setBackgroundColor:[UIColor flatBlueColor]];
}

- (void)save:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoBackRoot" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.dbc saveCurrencyChoice:self.currencyData];
}

- (void)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.currencyData = nil;
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
