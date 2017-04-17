//
//  UserInfoDao.m
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "UserInfoDao.h"

static NSString * const USERTABLE = @"USERTABLE";
@implementation UserInfoDao
+(instancetype)shareInstance{
    [super shareInstance];
    static UserInfoDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[UserInfoDao alloc]init];
        
    });
    [dao createTable];
    return dao;
}

- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE USERTABLE (userId integer,userName text,password text,headerImageUrl text,udid text,nickName text)";
    
    [UserInfoDao createUserTableWithSQL:createTableSQL tableName:USERTABLE];
}
+ (BOOL) checkUserWithUsertId:(NSString *)userId{
    return [[UserInfoDao shareInstance] checkUserWithUsertId:userId];
}
- (BOOL) checkUserWithUsertId:(NSString *)userId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM USERTABLE WHERE userId = '%@'",userId];
    __block BOOL flag = NO;
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            flag = YES;
        }
        [rs close];
    }];
    return flag;
}

/**
 保存用户信息

 @param item UserInfoModel
 */
+ (void) saveUserInfo:(UserInfoModel *)item{
    [[UserInfoDao shareInstance] saveUserInfo:item];
}
- (void) saveUserInfo:(UserInfoModel *)item{
    
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO USERTABLE (userId ,userName ,password ,headerImageUrl,udid,nickName) VALUES  ('%ld','%@','%@','%@','%@','%@')",item.userId,item.userName,item.password,item.headerImageUrl,self.imei,item.nickName];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:insertSql];
        if (flag) {
            
        }
    }];
    
}

+ (UserInfoModel *)getUserInfoWithPhoneUDID:(NSString *)udid{
    return [[UserInfoDao shareInstance] getUserInfoWithPhoneUDID:udid];
}
- (UserInfoModel *)getUserInfoWithPhoneUDID:(NSString *)udid{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM USERTABLE where udid='%@'",udid];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block UserInfoModel *item = nil;
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[UserInfoModel alloc]init];
            item.userId = [result intForColumn:@"userId"];
            item.userName = [result stringForColumn:@"userName"];
            item.password = [result stringForColumn:@"password"];
            item.headerImageUrl = [result stringForColumn:@"headerImageUrl"];
            item.nickName = [result stringForColumn:@"nickName"];
        }
        [result close];
    }];
    return item;
}
+ (UserInfoModel *)getUserInfoWithUserName:(NSString *)userName{
    return [[UserInfoDao shareInstance] getUserInfoWithUserName:userName];
}
- (UserInfoModel *)getUserInfoWithUserName:(NSString *)userName{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM USERTABLE where userName='%@'",userName];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block UserInfoModel *item = nil;
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[UserInfoModel alloc]init];
            item.userId = [result intForColumn:@"userId"];
            item.userName = [result stringForColumn:@"userName"];
            item.password = [result stringForColumn:@"password"];
            item.headerImageUrl = [result stringForColumn:@"headerImageUrl"];
            item.nickName = [result stringForColumn:@"nickName"];
        }
        [result close];
    }];
    return item;
}
+ (UserInfoModel *)getUserInfoWithUserId:(NSInteger )userId{
    return [[UserInfoDao shareInstance] getUserInfoWithUserId:userId];
}
- (UserInfoModel *)getUserInfoWithUserId:(NSInteger)userId{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM USERTABLE where userId='%ld'",userId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block UserInfoModel *item = nil;
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[UserInfoModel alloc]init];
            item.userId = [result intForColumn:@"userId"];
            item.userName = [result stringForColumn:@"userName"];
            item.password = [result stringForColumn:@"password"];
            item.headerImageUrl = [result stringForColumn:@"headerImageUrl"];
            item.nickName = [result stringForColumn:@"nickName"];
        }
        [result close];
    }];
    return item;
}
+ (void)updateUserInfo:(UserInfoModel *)item{
    [[UserInfoDao shareInstance] updateUserInfo:item];
}
- (void)updateUserInfo:(UserInfoModel *)item{
    NSString * sql = [NSString stringWithFormat:@"UPDATE USERTABLE SET userId = '%ld',userName = '%@',password = '%@',headerImageUrl = '%@',nickName = '%@' WHERE udid = '%@'",item.userId,item.userName,item.password,item.headerImageUrl,item.nickName,self.imei];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql];
        if (flag) {
            
        }
    }];
}

@end
