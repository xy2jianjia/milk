//
//  DetailChooseCell.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DetailChooseCell.h"
@interface DetailChooseCell ()

@property(nonatomic,strong) UILabel *tipLabel;
@property(nonatomic,strong) UILabel *titleLabel;
@property(nonatomic,strong) UILabel *countLabel;
@end

@implementation DetailChooseCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    
    _tipLabel = [[UILabel alloc]init];
    _tipLabel.frame = CGRectMake(5, 2, 40, 25);
    _tipLabel.font = [UIFont systemFontOfSize:13];
    _tipLabel.textColor = [UIColor lightGrayColor];
    _tipLabel.text = @"已选";
    [self.contentView addSubview:_tipLabel];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(_tipLabel.frame), 2, 130, 25);
    _titleLabel.font = [UIFont systemFontOfSize:13];
    _titleLabel.numberOfLines = 0;
    _titleLabel.text = @"开衩衣摆短袖T恤";
    [self.contentView addSubview:_titleLabel];
    
    _countLabel = [[UILabel alloc]init];
    _countLabel.frame = CGRectMake(CGRectGetMaxX(_titleLabel.frame) , 2, 40, 25);
    _countLabel.font = [UIFont systemFontOfSize:13];
    _countLabel.numberOfLines = 0;
    _countLabel.text = @" 1个";
    [self.contentView addSubview:_countLabel];
}
-(void)setModel:(GoodInfoModel *)model{
    _titleLabel.text = model.name;
    _countLabel.text = [NSString stringWithFormat:@"%ld 个",model.count];
//    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",model.price];
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
