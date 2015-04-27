//
//  CurrencyFormViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/24/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "CurrencyFormViewController.h"

@interface CurrencyFormViewController ()
@end

@implementation CurrencyFormViewController

@synthesize amount;

- (instancetype)init {
    if(self = [super init]) {
        XLFormDescriptor *formDescriptor = [XLFormDescriptor formDescriptor];
        XLFormSectionDescriptor *section;
        XLFormRowDescriptor *row;
        
        formDescriptor.assignFirstResponderOnShow = YES;
        
        // Basic Information - Section
        section = [XLFormSectionDescriptor formSection];
        [formDescriptor addFormSection:section];
        
        row = [XLFormRowDescriptor formRowDescriptorWithTag:@"amount" rowType:XLFormRowDescriptorTypeDecimal title:@"BTC"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"tintColor"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textLabel.color"];
        [row.cellConfig setObject:[UIColor flatBlueColor] forKey:@"backgroundColor"];
        [row.cellConfig setObject:[UIColor whiteColor] forKey:@"textField.textColor"];
        
        row.required = YES;
        [section addFormRow:row];
        
        return [super initWithForm:formDescriptor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor flatBlueColor]];
    self.amount = 1.0;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)formRowDescriptorValueHasChanged:(XLFormRowDescriptor *)formRow oldValue:(id)oldValue newValue:(id)newValue {
    if((newValue != [NSNull null])) 
        self.amount = [newValue floatValue];
    else
        self.amount = 1.0;
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
