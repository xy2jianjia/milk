//
//  CartViewCell.m
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "CartViewCell.h"

@interface CartViewCell ()
/**
 商品图片
 */
@property (nonatomic,strong) UIImageView *goodImageV;

/**
 商品标题
 */
@property (nonatomic,strong) UILabel *goodTitleLabel;

/**
 价格
 */
@property (nonatomic,strong) UILabel *priceLabel;

/**
 特征（颜色尺寸等等）
 */
@property (nonatomic,strong) UILabel *characterLabel;
@end

@implementation CartViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    CGFloat width = 90;
    _goodImageV = [[UIImageView alloc]init];
    _goodImageV.frame = CGRectMake(5, 5, width, width);
    _goodImageV.image = [UIImage imageNamed:@"timg"];
    _goodImageV.clipsToBounds = YES;
    _goodImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_goodImageV];
    
    _goodTitleLabel = [[UILabel alloc]init];
    _goodTitleLabel.frame = CGRectMake(CGRectGetMaxX(_goodImageV.frame) + 10, CGRectGetMinY(_goodImageV.frame),SCREEN_WIDTH - width - 30, 40);
    _goodTitleLabel.font = [UIFont systemFontOfSize:12];
    _goodTitleLabel.textAlignment = NSTextAlignmentCenter;
    _goodTitleLabel.text = @"创维（Skyworth）55H9A 55英寸超薄 无边框 25核4K超高清智能电视(黑色)";
    _goodTitleLabel.numberOfLines = 2;
    [self.contentView addSubview:_goodTitleLabel];
    
    _characterLabel = [[UILabel alloc]init];
    _characterLabel.frame = CGRectMake(CGRectGetMaxX(_goodImageV.frame) + 10, CGRectGetMaxY(_goodTitleLabel.frame), CGRectGetWidth(_goodTitleLabel.frame) , 18);
    _characterLabel.font = [UIFont systemFontOfSize:11];
    _characterLabel.textColor = [UIColor lightGrayColor];
    _characterLabel.text = @"颜色：薄荷绿  尺码：170/92A";
    [self.contentView addSubview:_characterLabel];
    
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.frame = CGRectMake(CGRectGetMaxX(_goodImageV.frame) + 10, CGRectGetMaxY(_goodImageV.frame) - 25, 100 , 20);
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.text = @"¥ 329.00";
    [self.contentView addSubview:_priceLabel];
}
@end
