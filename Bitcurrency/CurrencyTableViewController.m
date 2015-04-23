//
//  CurrencyTableViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "CurrencyTableViewController.h"

@interface CurrencyTableViewController ()
@property (nonatomic, strong) NSArray *currencies;
@property (nonatomic, strong) NSMutableArray *chosenCurrencies;
@end

@implementation CurrencyTableViewController

static NSString *CellIdentifier = @"CurrencyCell";

- (id)init {
    if(self = [super init]) {
        self.dbc = [[DatabaseController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Select Currency";
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    NSString *url = @"https://bitpay.com/api/rates/";
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.currencies = responseObject;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
    
    [self.tableView registerClass:[CurrencyTableViewCell class] forCellReuseIdentifier:CellIdentifier];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callFromBeyond:) name:@"GoBackRoot" object:nil];
    
    [self updateGradient];
}

- (void)callFromBeyond:(NSNotification *)notification {
    if ([[notification name] isEqualToString:@"GoBackRoot"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.currencies count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CurrencyTableViewCell *cell = (CurrencyTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[CurrencyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell...
    NSDictionary *data = [self.currencies objectAtIndex:indexPath.row];

    [cell setUserInteractionEnabled:YES];
    [cell.textLabel setText:[data objectForKey:@"name"]];
    [cell.textLabel setTextColor:[UIColor whiteColor]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.currencies objectAtIndex:indexPath.row];
    CurrencyDetailViewController *cdvc = [[CurrencyDetailViewController alloc] init];
    cdvc.currencyData = data;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cdvc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.currencies objectAtIndex:indexPath.row];

    if([self.chosenCurrencies count] > 0) {
        [self.chosenCurrencies each:^(id object) {
            if([[object objectForKey:@"code"] isEqualToString:[data objectForKey:@"code"]]) {
                [cell setAlpha:0.5];
                [cell setUserInteractionEnabled:NO];
            }
        }];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];

    self.chosenCurrencies = [self.dbc getUserCurrencies];
}

- (void)updateGradient {
    [self.tableView setOpaque:NO];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor flatBlueColor]];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
