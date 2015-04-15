//
//  Database.h
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
@interface Database : NSObject
@property (strong, nonatomic) FMDatabase *db;

+ (id) sharedDatabase;
- (void)initDB;
- (FMDatabase *)getDB;
@end
