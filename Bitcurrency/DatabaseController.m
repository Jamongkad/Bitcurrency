//
//  DatabaseController.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "DatabaseController.h"

@implementation DatabaseController

-(instancetype) init {
    if(self = [super init]) {
        _sharedDB = [Database sharedDatabase];
        [_sharedDB initDB];
        _db = [_sharedDB getDB];
    }
    
    return self;
}

- (void)createTablesAndSeed {
    _success = [_db tableExists:@"ChosenCurrency"];
    
    if(!_success) {
        NSString *sql = @"CREATE TABLE ChosenCurrency ("
             "id integer primary key autoincrement not null,"
             "currencyOrder integer(10) not null,"
             "code varchar(5) not null,"
             "name varchar(100) not null,"
             "amount numeric(10,2) not null,"
             "btcAmount numeric(10,2) not null,"
             "timestamp DATE DEFAULT CURRENT_TIMESTAMP"
             ");";
        _success = [_db executeUpdate:sql];
        if(!_success) {
            NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
        }
    }
    
    _success = [_db tableExists:@"CurrencyPlot"];
    
    if(!_success) {
        NSString *sql = @"CREATE TABLE CurrencyPlot ("
             "id integer primary key autoincrement not null,"
             "code varchar(5) not null,"
             "name varchar(100) not null,"
             "amount numeric(10,2) not null,"
             "timestamp DATE DEFAULT CURRENT_TIMESTAMP"
             ");";
        _success = [_db executeUpdate:sql];
        if(!_success) {
            NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
        }
    }
}

- (NSMutableArray *)getUserCurrencies {

    NSString *sql = @"SELECT * FROM ChosenCurrency ORDER BY currencyOrder";
    FMResultSet *rs = [_db executeQuery:sql];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    if(!rs) {
        NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
    }
    
    while([rs next]) {
        NSDictionary *currencyData = @{
            @"id": [rs stringForColumn:@"id"],
            @"currencyOrder": [rs stringForColumn:@"currencyOrder"],
            @"name": [rs stringForColumn:@"name"],
            @"code": [rs stringForColumn:@"code"],
            @"btcAmount": [rs stringForColumn:@"btcAmount"],
            @"rate": [rs stringForColumn:@"amount"],
        };
        
        [results addObject: currencyData];
    }
    
    return results;
}

- (void)saveCurrencyChoice:(id)currencyObj {
    
    NSString *creationSql = @"INSERT INTO ChosenCurrency ("
                              "currencyOrder,"
                              "code,"
                              "name,"
                              "amount,"
                              "btcAmount"
                              ") VALUES (0, %@, %@, %@, %@);";
    
    NSString *code = [[currencyObj objectForKey:@"code"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *name = [[currencyObj objectForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    id amount = [currencyObj objectForKey:@"rate"];
    id btcAmount = [currencyObj objectForKey:@"btcAmount"];
    
    _success = [_db executeUpdateWithFormat:creationSql, code, name, amount, btcAmount];
    
    NSString *orderSql = @"UPDATE ChosenCurrency SET currencyOrder = (SELECT ROWID FROM ChosenCurrency ORDER BY ROWID DESC LIMIT 1)"
                          " WHERE id = (SELECT ROWID FROM ChosenCurrency ORDER BY ROWID DESC LIMIT 1);";
    _success = [_db executeUpdate:orderSql];
    
    if(!_success) {
        NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
    }
}

- (void)removeCurrency:(NSDictionary *)currencyObj {
    NSString *sql = @"DELETE FROM ChosenCurrency WHERE id = ?";
    _success = [_db executeUpdate:sql, [currencyObj objectForKey:@"id"]];
    
    if(!_success) {
        NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
    }
}

- (void)reorderCurrencies:(NSArray *)objects {
    [objects eachWithIndex:^(id object, NSUInteger index) {
        NSString *sql = @"UPDATE ChosenCurrency SET currencyOrder = ? WHERE id = ?";
        _success = [_db executeUpdate:sql, [NSNumber numberWithUnsignedLongLong:index + 1], [object objectForKey:@"id"]];

        if(!_success) {
            NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
        }

    }];
}

@end
