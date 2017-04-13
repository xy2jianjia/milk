//
//  OrderModel.h
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OrderModel : NSObject

/**
 订单id
 */
@property (nonatomic,strong) NSString *orderId;

/**
 商品信息
 */
@property (nonatomic,strong) NSString *goodIds;

/**
 收货人姓名
 */
@property (nonatomic,strong) NSString *receiverName;

/**
 收货人电话
 */
@property (nonatomic,strong) NSString *receiverTel;

/**
 地址
 */
@property (nonatomic,strong) NSString *address;

/**
 支付类型
 */
@property (nonatomic,assign) NSInteger payType;

/**
 发票信息
 */
@property (nonatomic,strong) NSString *invoice;

/**
 订单总额
 */
@property (nonatomic,assign) float totalAmount;

/**
 运费
 */
@property (nonatomic,assign) float freight;

/**
 订单时间
 */
@property (nonatomic,strong) NSString *time;

/**
 订单状态0:待支付；1、完成支付
 */
@property (nonatomic,assign) NSInteger status;

@end
