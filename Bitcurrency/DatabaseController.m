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

    NSString *sql = @"SELECT * FROM ChosenCurrency ORDER BY id DESC";
    FMResultSet *rs = [_db executeQuery:sql];
    
    NSMutableArray *results = [[NSMutableArray alloc] init];
    
    if(!rs) {
        NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
    }
    
    while([rs next]) {
        NSDictionary *currencyData = @{
            @"name": [rs stringForColumn:@"name"],
            @"code": [rs stringForColumn:@"code"],
            @"rate": [rs stringForColumn:@"amount"],
        };
        
        [results addObject: currencyData];
    }
    
    return results;
}

- (void)saveCurrencyChoice:(NSDictionary *)currencyObj {
    NSString *creationSql = @"INSERT INTO ChosenCurrency ("
                              "code,"
                              "name,"
                              "amount"
                              ") VALUES (%@, %@, %@)";
    
    NSString *code = [[currencyObj objectForKey:@"code"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *name = [[currencyObj objectForKey:@"name"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    id amount = [currencyObj objectForKey:@"rate"];
    _success = [_db executeUpdateWithFormat:creationSql, code, name, amount];
    
    if(!_success) {
        NSLog(@"%s: executeQuery failed: %@", __FUNCTION__, [_db lastErrorMessage]);
    }
}

@end
