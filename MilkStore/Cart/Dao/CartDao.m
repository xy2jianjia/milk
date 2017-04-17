//
//  CartDao.m
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "CartDao.h"

static NSString * const CARTTABLE = @"CARTTABLE";
@implementation CartDao
+(instancetype)shareInstance{
    [super shareInstance];
    static CartDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[CartDao alloc]init];
        
    });
    [dao createTable];
    return dao;
}

- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE CARTTABLE (cartId text,goodsId text,goodsName text,goodImageUrl text,goodCharater text,price float,count integer,userId intger,udid text,isSelected integer)";
    
    [CartDao createUserTableWithSQL:createTableSQL tableName:CARTTABLE];
}
+ (BOOL) checkUserWithCartId:(NSString *)cartId{
    return [[CartDao shareInstance] checkUserWithCartId:cartId];
}
- (BOOL) checkUserWithCartId:(NSString *)cartId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM CARTTABLE WHERE cartId = '%@'",cartId];
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
 
 @param item CartModel
 */
+ (void) saveCartInfo:(CartModel *)item userId:(NSInteger )userId{
    [[CartDao shareInstance] saveCartInfo:item userId:userId];
}
- (void) saveCartInfo:(CartModel *)item userId:(NSInteger )userId{
    
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO CARTTABLE (cartId ,goodsId  ,goodsName ,goodImageUrl ,goodCharater ,price ,count ,userId,udid,isSelected) VALUES  ('%@','%ld','%@','%@','%@','%.2f','%ld','%ld','%@','%ld')",item.cartId,item.goodsId,item.goodsName,item.goodImageUrl,item.goodCharater,item.price,item.count,userId,self.imei,[[NSNumber numberWithBool:item.isSelected] integerValue]];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:insertSql];
        if (flag) {
            
        }
    }];
    
}

+ (NSMutableArray *)getCartInfoWithPhoneUDID:(NSString *)udid{
    return [[CartDao shareInstance] getCartInfoWithPhoneUDID:udid];
}
- (NSMutableArray *)getCartInfoWithPhoneUDID:(NSString *)udid{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM CARTTABLE where udid='%@'",udid];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block CartModel *item = nil;
    NSMutableArray *temp = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[CartModel alloc]init];
            item.cartId = [result stringForColumn:@"cartId"];
            item.goodsId = [result intForColumn:@"goodsId"];
            item.goodsName = [result stringForColumn:@"goodsName"];
            item.goodImageUrl = [result stringForColumn:@"goodImageUrl"];
            item.goodCharater = [result stringForColumn:@"goodCharater"];
            
            item.price = [result doubleForColumn:@"price"];
            item.count = [result intForColumn:@"count"];
            item.userId = [result intForColumn:@"userId"];
            item.udid = [result stringForColumn:@"udid"];
            item.isSelected = [result intForColumn:@"isSelected"];
            [temp addObject:item];
        }
        [result close];
    }];
    return temp;
}
+ (CartModel *)getCartInfoWithCartId:(NSString *)cartId{
    return [[CartDao shareInstance] getCartInfoWithCartId:cartId];
}
- (CartModel *)getCartInfoWithCartId:(NSString *)cartId{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM CARTTABLE where cartId='%@'",cartId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block CartModel *item = nil;
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[CartModel alloc]init];
            item.cartId = [result stringForColumn:@"cartId"];
            item.goodsId = [result intForColumn:@"goodsId"];
            item.goodsName = [result stringForColumn:@"goodsName"];
            item.goodImageUrl = [result stringForColumn:@"goodImageUrl"];
            item.goodCharater = [result stringForColumn:@"goodCharater"];
            
            item.price = [result doubleForColumn:@"price"];
            item.count = [result intForColumn:@"count"];
            item.userId = [result intForColumn:@"userId"];
            item.udid = [result stringForColumn:@"udid"];
            item.isSelected = [result intForColumn:@"isSelected"];
        }
        [result close];
    }];
    return item;
}
+ (void)updateCartInfo:(CartModel *)item{
    [[CartDao shareInstance] updateCartInfo:item];
}
- (void)updateCartInfo:(CartModel *)item{
    NSString * sql = [NSString stringWithFormat:@"UPDATE CARTTABLE SET goodsId = '%ld',goodsName = '%@',goodImageUrl = '%@',goodCharater = '%@',price = '%.2f',count = '%ld',userId = '%ld',isSelected = '%ld' WHERE cartId = '%@'",item.goodsId,item.goodsName,item.goodImageUrl,item.goodCharater,item.price,item.count,item.userId,[[NSNumber numberWithBool:item.isSelected] integerValue],item.cartId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql];
        if (flag) {
            
        }
    }];
}
+ (void) deleteCartInfoWithId:(NSString *)cartId{
    [[CartDao shareInstance] deleteCartInfoWithId:cartId ];
}
- (void) deleteCartInfoWithId:(NSString *)cartId{
    
    NSString * insertSql = [NSString stringWithFormat:@"DELETE FROM CARTTABLE WHERE cartId = '%@'",cartId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:insertSql];
        if (flag) {
            
        }
    }];
}
+ (NSInteger )getTotalCartCount{
    return [[CartDao shareInstance] getTotalCartCount];
}
- (NSInteger )getTotalCartCount{
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM CARTTABLE "];
    __block NSInteger flag = 0;
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            flag = [rs intForColumn:@"COUNT(*)"];
        }
        [rs close];
    }];
    return flag;
}

@end
