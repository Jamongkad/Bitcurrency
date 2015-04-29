//
//  CurrencyDetailViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/23/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "CurrencyDetailViewController.h"

@interface CurrencyDetailViewController ()
@property (nonatomic, strong) CurrencyFormViewController *cfvc;
@property (nonatomic, strong) UILabel *currencyRate;
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
    
    NSLog(@"%@ data", self.currencyData);
    
    self.cfvc = [[CurrencyFormViewController alloc] init];
    [self addChildViewController:self.cfvc];
    
    UILabel *currencyName = [[UILabel alloc] init];
    UILabel *currencyCode = [[UILabel alloc] init];
    self.currencyRate = [[UILabel alloc] init];
    UILabel *btcLabel = [[UILabel alloc] init];
    UIView *rateHolder = [[UIView alloc] init];
  
    NSNumber *amount = [self.currencyData objectForKey:@"rate"];
    
    [currencyName setText:[self.currencyData objectForKey:@"name"]];
    [currencyName setTextColor:[UIColor whiteColor]];

    [currencyCode setText:[self.currencyData objectForKey:@"code"]];
    [currencyCode setTextColor:[UIColor whiteColor]];
    
    [self updateCurrencyRate:amount];
    
    [btcLabel setTextColor:[UIColor whiteColor]];
    
    [rateHolder addSubview:btcLabel];
    [rateHolder addSubview:currencyCode];
    [rateHolder addSubview:self.currencyRate];
    
    [self.view addSubview:self.cfvc.view];
    [self.view addSubview:currencyName];
    [self.view addSubview:rateHolder];
    
    UIEdgeInsets textPadding = UIEdgeInsetsMake(3, 3, 3, 3);
    
    [currencyName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(100);
        make.centerX.equalTo(self.view);
    }];
    
    [rateHolder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currencyName.mas_bottom);
        make.centerX.equalTo(currencyName);
    }];
    
        [btcLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rateHolder.mas_top);
            make.left.equalTo(rateHolder.mas_left);
        }];
    
        [currencyCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rateHolder.mas_top);
            make.right.equalTo(self.currencyRate.mas_left).insets(textPadding);
            make.left.equalTo(btcLabel.mas_right);
        }];

        [self.currencyRate mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(rateHolder.mas_top);
            make.right.equalTo(rateHolder.mas_right);
        }];

    [self.cfvc.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btcLabel.mas_bottom);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
    [RACObserve(self.cfvc, amount) subscribeNext:^(id x) {
        [btcLabel setText:[NSString stringWithFormat:@"BTC %f = ", [x floatValue]]];
        float newAmount = [amount floatValue] * [x floatValue];
        [self updateCurrencyRate:[NSNumber numberWithFloat:newAmount]];
    }];
}

- (void)updateCurrencyRate:(NSNumber *)amount {
    NSNumberFormatter *currencyFormat = [[NSNumberFormatter alloc] init];
    [currencyFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
    [currencyFormat setCurrencySymbol:@""];
    
    [self.currencyRate setText:[NSString stringWithFormat:@"%@", [currencyFormat stringFromNumber:amount]]];
    [self.currencyRate setTextColor:[UIColor whiteColor]];
}

- (void)save:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"GoBackRoot" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionaryWithDictionary:self.currencyData];
    [mutableDict setObject:@(self.cfvc.amount) forKey:@"btcAmount"];
    [self.dbc saveCurrencyChoice:mutableDict];
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
