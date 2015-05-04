//
//  DashboardTableViewController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "DashboardTableViewController.h"

@interface DashboardTableViewController ()
@property (nonatomic, strong) NSMutableArray *currencies;
@end

@implementation DashboardTableViewController

static NSString *CellIdentifier = @"DashCell";

- (id)init {
    if(self = [super init]) {
        self.dbc = [[DatabaseController alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView registerClass:[RatesTableViewCell class] forCellReuseIdentifier:CellIdentifier];
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
    [self reloadCurrencyData];
    NSInteger count = [self.currencies count];
    return count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self reloadCurrencyData];
    
    RatesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSDictionary *data = [self.currencies objectAtIndex:indexPath.row];
    
    NSString *url = [NSString stringWithFormat:@"https://bitpay.com/api/rates/%@", [data objectForKey:@"code"]];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id netRate = [responseObject objectForKey:@"rate"];
        id btcAmount = [data objectForKey:@"btcAmount"];
        float myRate = [btcAmount floatValue] * [netRate floatValue];
        
        NSNumberFormatter *currencyFormat = [[NSNumberFormatter alloc] init];
        [currencyFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
        [currencyFormat setCurrencySymbol:@""];
        NSNumber *rate = [NSNumber numberWithFloat:myRate];

        [cell.currencyRate setTextColor:[UIColor whiteColor]];
        [cell.currencyRate setText:[NSString stringWithFormat:@"%@", [currencyFormat stringFromNumber:rate]]];
        
        [cell.currencyLabel setTextColor:[UIColor lightTextColor]];
        [cell.currencyLabel setText:[data objectForKey:@"code"]];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
  
    [cell.bitcoinAmount setTextColor:[UIColor whiteColor]];
    [cell.bitcoinAmount setText:[NSString stringWithFormat:@"%.2f", [[data objectForKey:@"btcAmount"] floatValue]]];
    
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self reloadCurrencyData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *data = [self.currencies objectAtIndex:indexPath.row];
    
    CurrencyDetailViewController *cdvc = [[CurrencyDetailViewController alloc] init];
    cdvc.currencyData = data;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cdvc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)reloadCurrencyData {
    self.currencies = [self.dbc getUserCurrencies];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSString *stringToMove = [self.currencies objectAtIndex:sourceIndexPath.row];
    [self.currencies removeObjectAtIndex:sourceIndexPath.row];
    [self.currencies insertObject:stringToMove atIndex:destinationIndexPath.row];
    [self.dbc reorderCurrencies:self.currencies];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(editingStyle == UITableViewCellEditingStyleDelete) {
        [self reloadCurrencyData];
        [self.dbc removeCurrency:[self.currencies objectAtIndex:indexPath.row]];
        [self.currencies removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject: indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
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
