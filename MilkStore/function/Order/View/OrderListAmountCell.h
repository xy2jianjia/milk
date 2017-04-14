//
//  OrderListAmountCell.h
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderListAmountCell : UITableViewCell
@property (nonatomic,strong) OrderModel *orderModel;
-(void)setOrderModel:(OrderModel *)orderModel;
@end
