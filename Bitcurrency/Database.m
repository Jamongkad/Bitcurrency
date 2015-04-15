//
//  Database.m
//  Bitcurrency
//
//  Created by Mathew Wong on 4/14/15.
//  Copyright (c) 2015 YidgetSoft. All rights reserved.
//

#import "Database.h"

@implementation Database

static Database *sharedDatabase = nil;

+(Database *)sharedDatabase {
    if(sharedDatabase == nil) {
        sharedDatabase = [[super allocWithZone:NULL] init];
    }
    
    return sharedDatabase;
}

-(void)initDB {
    NSString *databaseName = @"Database.db";
    NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDir = [documentDirectory objectAtIndex:0];
    NSString *path = [documentDir stringByAppendingPathComponent:databaseName];
    
    _db = [FMDatabase databaseWithPath:path];
    
    if(![_db open])
        NSLog(@"There is a problem with the database.");
}

-(FMDatabase *)getDB {
    return _db;
}

-(id)init {
    self  = [super init];
    if(self) {
    
    }
    return self;
}

-(id)copyWithZone:(NSZone *)zone {
    return self;
}
@end
