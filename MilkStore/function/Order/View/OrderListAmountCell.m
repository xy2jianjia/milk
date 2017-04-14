//
//  OrderListAmountCell.m
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "OrderListAmountCell.h"

@interface OrderListAmountCell ()
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@end

@implementation OrderListAmountCell
-(void)setOrderModel:(OrderModel *)orderModel{
    NSArray *arr =  [orderModel.cartIds componentsSeparatedByString:@","];
    _countLabel.text = [NSString stringWithFormat:@"共%ld件商品",arr.count];
    _amountLabel.text = [NSString stringWithFormat:@"实付款¥%.2f",orderModel.totalAmount];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
