//
//  OrderInfoAmountCell.m
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "OrderInfoAmountCell.h"

@interface OrderInfoAmountCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end

@implementation OrderInfoAmountCell


- (void)setTitle:(NSString *)title amount:(float)amount{
    _nameLabel.text = title;
    _amountLabel.text = [NSString stringWithFormat:@"¥%.2f",amount];
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
