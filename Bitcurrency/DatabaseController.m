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

@end
