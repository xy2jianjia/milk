//
//  DetailNameCell.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DetailNameCell.h"

@interface DetailNameCell ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *activityLabel;
@property (nonatomic,strong) UILabel *priceLabel;

@end


@implementation DetailNameCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = @"MO&Co.圆领错位条纹拼接不规则开衩衣摆短袖T恤MA171TEE224 moco";
    [self.contentView addSubview:_titleLabel];
    
    _activityLabel = [[UILabel alloc]init];
    _activityLabel.frame = CGRectMake(0, CGRectGetMaxY(_titleLabel.frame), SCREEN_WIDTH, 40);
    _activityLabel.font = [UIFont systemFontOfSize:12];
    _activityLabel.textColor = [UIColor redColor];
    _activityLabel.numberOfLines = 0;
    _activityLabel.text = @"预售正宗陕西有机桃子 水蜜桃 油桃孕妇水果5斤包邮 个大 味甜 很绿色 前500份12.9元5斤 7月初发货";
    [self.contentView addSubview:_activityLabel];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.frame = CGRectMake(10, CGRectGetMaxY(_activityLabel.frame)+5, 60, 25);
    _priceLabel.font = [UIFont systemFontOfSize:15];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.text = @"¥ 59.90";
    [self.contentView addSubview:_priceLabel];
}
-(void)setModel:(GoodInfoModel *)model{
    _titleLabel.text = model.name;
    _activityLabel.text = model.charater;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.price];
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
