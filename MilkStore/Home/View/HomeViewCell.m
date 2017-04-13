//
//  HomeViewCell.m
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "HomeViewCell.h"


@interface HomeViewCell ()
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
 加入购物车
 */
@property (nonatomic,strong) UIButton *cartButton;

@end

@implementation HomeViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configViews];
    }
    return self;
}
- (void)configViews{
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    CGFloat width = self.bounds.size.width;
    _goodImageV = [[UIImageView alloc]init];
    _goodImageV.frame = CGRectMake(0, 0, width, width);
//    _goodImageV.image = [UIImage imageNamed:@"timg"];
    _goodImageV.clipsToBounds = YES;
    _goodImageV.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_goodImageV];
    
    _goodTitleLabel = [[UILabel alloc]init];
    _goodTitleLabel.frame = CGRectMake(0, CGRectGetMaxY(_goodImageV.frame), width, 40);
    _goodTitleLabel.font = [UIFont systemFontOfSize:12];
    _goodTitleLabel.textAlignment = NSTextAlignmentCenter;
//    _goodTitleLabel.text = @"创维（Skyworth）55H9A 55英寸超薄 无边框 25核4K超高清智能电视(黑色)";
    _goodTitleLabel.numberOfLines = 2;
    [self.contentView addSubview:_goodTitleLabel];
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.frame = CGRectMake(5, CGRectGetMaxY(_goodTitleLabel.frame), (width - 20)/2 , 20);
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
//    _priceLabel.text = @"¥ 329.00";
    [self.contentView addSubview:_priceLabel];
    
    _cartButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _cartButton.frame = CGRectMake((width - 20)/2 + 10, CGRectGetMinY(_priceLabel.frame), (width - 20)/2, 20);
    [_cartButton setTitle:@"加入购物车" forState:(UIControlStateNormal)];
    _cartButton.layer.borderColor = [UIColor redColor].CGColor;
    _cartButton.layer.borderWidth = 0.5;
    [_cartButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    _cartButton.titleLabel.font = [UIFont systemFontOfSize:11];
    _cartButton.layer.cornerRadius = 8;
    [_cartButton addTarget:self action:@selector(addToCart) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_cartButton];
    
}
-(void)setGoodInfoModel:(GoodInfoModel *)goodInfoModel{
    _goodInfoModel = goodInfoModel;
    NSString *imageUrl = goodInfoModel.image;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageUrl]];
    if (!image) {
        image = [UIImage imageNamed:@"list_item_icon"];
    }
    _goodImageV.image = image;
    NSString *name = goodInfoModel.name;
    _goodTitleLabel.text = name;
    CGFloat price = goodInfoModel.price;
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",price];
}
- (void)addToCart{
    UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserId:[NSString stringWithFormat:@"%ld",self.userId]];
    CartModel *item = [[CartModel alloc]init];
    item.cartId = [self uuid];
    item.goodCharater = _goodInfoModel.charater;
    item.goodsName = _goodInfoModel.name;
    item.goodsId = _goodInfoModel.id;
    item.goodImageUrl = _goodInfoModel.image;

    item.price = _goodInfoModel.price;
    item.count = 1;
    item.userId = userInfo.userId;
    item.udid = self.imei;

    [CartDao saveCartInfo:item userId:userInfo.userId];
//    [self showHint:@"已添加到购物车"];
}

@end
