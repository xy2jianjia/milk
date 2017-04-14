//
//  OrderDao.m
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "OrderDao.h"
static NSString * const ORDERTABLE = @"ORDERTABLE";
@implementation OrderDao
+(instancetype)shareInstance{
    [super shareInstance];
    static OrderDao *dao = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dao = [[OrderDao alloc]init];
        
    });
    [dao createTable];
    return dao;
}

- (void)createTable{
    NSString *createTableSQL = @"CREATE TABLE ORDERTABLE (orderId text,receiverName text,receiverTel text,address text,payType integer,invoice float,totalAmount float,freight text,cartIds text,time text,status integer)";
    
    [OrderDao createUserTableWithSQL:createTableSQL tableName:ORDERTABLE];
}
+ (BOOL) checkOrderWithOrderId:(NSString *)orderId{
    return [[OrderDao shareInstance] checkOrderWithOrderId:orderId];
}
- (BOOL) checkOrderWithOrderId:(NSString *)orderId{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM ORDERTABLE WHERE orderId = '%@'",orderId];
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
 
 @param item OrderModel
 */
+ (void) saveOrderInfo:(OrderModel *)item {
    [[OrderDao shareInstance] saveCartInfo:item ];
}
- (void) saveCartInfo:(OrderModel *)item {
//    orderId ,receiverName ,receiverTel ,address ,payType ,invoice ,totalAmount ,freight ,goodId
    NSString * insertSql = [NSString stringWithFormat:@"INSERT INTO ORDERTABLE VALUES  ('%@','%@','%@','%@','%ld','%@','%.2f','%.2f','%@','%@','%ld')",item.orderId,item.receiverName,item.receiverTel,item.address,item.payType,item.invoice,item.totalAmount,item.freight,item.cartIds,item.time,item.status];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:insertSql];
        if (flag) {
            
        }
    }];
    
}

+ (NSMutableArray *)getOrderList{
    return [[OrderDao shareInstance] getOrderList];
}
- (NSMutableArray *)getOrderList{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM ORDERTABLE "];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block OrderModel *item = nil;
    NSMutableArray *temp = [NSMutableArray array];
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[OrderModel alloc]init];
            item.orderId = [result stringForColumn:@"orderId"];
            item.receiverName = [result stringForColumn:@"receiverName"];
            item.receiverTel = [result stringForColumn:@"receiverTel"];
            item.address = [result stringForColumn:@"address"];
            item.payType = [result intForColumn:@"payType"];
            item.invoice = [result stringForColumn:@"invoice"];
            item.totalAmount = [result doubleForColumn:@"totalAmount"];
            item.freight = [result doubleForColumn:@"freight"];
            item.cartIds = [result stringForColumn:@"cartIds"];
            item.time = [result stringForColumn:@"time"];
            item.status = [result intForColumn:@"status"];
            [temp addObject:item];
        }
        [result close];
    }];
    return temp;
}
+ (OrderModel *)getOrderInfoWithOrderId:(NSString *)orderId{
    return [[OrderDao shareInstance] getOrderInfoWithOrderId:(NSString *)orderId];
}
- (OrderModel *)getOrderInfoWithOrderId:(NSString *)orderId{
    NSString * sql=[NSString stringWithFormat:@"SELECT * FROM ORDERTABLE where orderId='%@'",orderId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    __block OrderModel *item = nil;
    [queue inDatabase:^(FMDatabase *db) {
        FMResultSet *result = [db executeQuery:sql];
        while ([result next]) {
            item = [[OrderModel alloc]init];
            item.orderId = [result stringForColumn:@"orderId"];
            item.receiverName = [result stringForColumn:@"receiverName"];
            item.receiverTel = [result stringForColumn:@"receiverTel"];
            item.address = [result stringForColumn:@"address"];
            item.payType = [result intForColumn:@"payType"];
            item.invoice = [result stringForColumn:@"invoice"];
            item.totalAmount = [result doubleForColumn:@"totalAmount"];
            item.freight = [result doubleForColumn:@"freight"];
            item.cartIds = [result stringForColumn:@"cartIds"];
            item.time = [result stringForColumn:@"time"];
            item.status = [result intForColumn:@"status"];
        }
        [result close];
    }];
    return item;
}
+ (void)updateCartInfo:(OrderModel *)item{
    [[OrderDao shareInstance] updateCartInfo:item];
}
- (void)updateCartInfo:(OrderModel *)item{
//    orderId ,receiverName ,receiverTel ,address ,payType ,invoice ,totalAmount ,freight ,goodId
    NSString * sql = [NSString stringWithFormat:@"UPDATE ORDERTABLE SET receiverName = '%@',receiverTel = '%@',address = '%@',payType = '%ld',invoice = '%@',totalAmount = '%.2f',freight = '%.2f',cartIds = '%@',status = '%ld' WHERE orderId = '%@'",item.receiverName,item.receiverTel,item.address,item.payType,item.invoice,item.totalAmount,item.freight,item.cartIds,item.status,item.orderId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:sql];
        if (flag) {
            
        }
    }];
}
+ (void) deleteOrderInfoWithOrderId:(NSString *)orderId{
    [[OrderDao shareInstance] deleteOrderInfoWithOrderId:orderId ];
}
- (void) deleteOrderInfoWithOrderId:(NSString *)orderId{
    
    NSString * insertSql = [NSString stringWithFormat:@"DELETE FROM ORDERTABLE WHERE orderId = '%@'",orderId];
    FMDatabaseQueue *queue = [DBHelper getDatabaseQueue];
    [queue inDatabase:^(FMDatabase *db) {
        BOOL flag = [db executeUpdate:insertSql];
        if (flag) {
            
        }
    }];
    
}
@end
