//
//  RCloudMessage
//
//  Created by wbj on 15/6/3.
//  Copyright (c) 2015年 wbj. All rights reserved.
//

#import "DBManager.h"
#import "DBHelper.h"
@implementation DBManager

#pragma mark - Singleton
+ (instancetype)shareInstance{
    static DBManager* instance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        instance = [[[self class] alloc] init];
//        [instance createUserTable];
    });
    return instance;
}
//创建用户存储表
+ (void)createUserTableWithSQL:(NSString *)sql tableName:(NSString *)tableName{
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        if (![DBHelper isTableOK: tableName withDB:db]) {
            [db executeUpdate:sql];
        }
    }];
}
+ (void)isColumnExistWithColumnName:(NSString *)columnName tableName:(NSString *)tableName{
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        // 判断字段是否存在
        if ([db columnExists:columnName inTableWithName:tableName]) {
            
        }else{
            NSString *sql = [NSString stringWithFormat:@"ALTER TABLE %@ ADD %@ text",tableName,columnName];
            [db executeUpdate:sql];
        }
    }];
    
}


@end
