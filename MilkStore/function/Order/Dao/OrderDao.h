//
//  OrderDao.h
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DBManager.h"

@interface OrderDao : DBManager
+ (BOOL) checkOrderWithOrderId:(NSString *)orderId;
+ (void) saveOrderInfo:(OrderModel *)item ;
+ (NSMutableArray *)getOrderList;
+ (OrderModel *)getOrderInfoWithOrderId:(NSString *)orderId;
+ (void)updateCartInfo:(OrderModel *)item;
+ (void) deleteOrderInfoWithOrderId:(NSString *)orderId;
@end
