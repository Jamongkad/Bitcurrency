//
//  DatabaseController.h
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "Database.h"
#import "ObjectiveSugar.h"

@interface DatabaseController : NSObject
@property (nonatomic) BOOL success;
@property (nonatomic, strong) FMDatabase *db;
@property (nonatomic, strong) Database *sharedDB;
@property (nonatomic, strong) NSString *tableSql;

-(void)createTablesAndSeed;
-(void)saveCurrencyChoice:(NSDictionary *)currencyObj;
-(void)reorderCurrencies:(NSArray *)objects;
-(void)removeCurrency:(NSDictionary *)currencyObj;
-(NSMutableArray *)getUserCurrencies;
@end