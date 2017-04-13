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
 选择图片
 */
@property (nonatomic,strong) UIButton *selectBtn;
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

/**
 是否选择了
 */
//@property (nonatomic,assign) BOOL isSelected;

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
//    _isSelected = NO;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 80);
    _selectBtn = [[UIButton alloc]init];
    _selectBtn.frame = CGRectMake(5, CGRectGetMidY(self.bounds) - 8, 16, 16);
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"reg_unchecked"] forState:(UIControlStateNormal)];
    [_selectBtn setBackgroundImage:[UIImage imageNamed:@"reg_checked"] forState:(UIControlStateSelected)];
    [_selectBtn addTarget:self action:@selector(selectACtion:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.contentView addSubview:_selectBtn];
    
    CGFloat width = 60;
    _goodImageV = [[UIImageView alloc]init];
    _goodImageV.frame = CGRectMake(CGRectGetMaxX(_selectBtn.frame)+10, 10, width, width);
//    _goodImageV.image = [UIImage imageNamed:@"list_item_icon"];
    _goodImageV.clipsToBounds = YES;
    _goodImageV.contentMode = UIViewContentModeScaleAspectFill;
    _goodImageV.layer.borderWidth = 0.5;
    _goodImageV.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.contentView addSubview:_goodImageV];
    
    _goodTitleLabel = [[UILabel alloc]init];
    _goodTitleLabel.frame = CGRectMake(CGRectGetMaxX(_goodImageV.frame) + 10, CGRectGetMinY(_goodImageV.frame),SCREEN_WIDTH - width - 30, 40);
    _goodTitleLabel.font = [UIFont systemFontOfSize:15];
    _goodTitleLabel.textAlignment = NSTextAlignmentLeft;
//    _goodTitleLabel.text = @"创维（Skyworth）55H9A 55英寸超薄 无边框 25核4K超高清智能电视(黑色)";
    _goodTitleLabel.numberOfLines = 2;
    [self.contentView addSubview:_goodTitleLabel];
    
    _characterLabel = [[UILabel alloc]init];
    _characterLabel.frame = CGRectMake(CGRectGetMaxX(_goodImageV.frame) + 10, CGRectGetMaxY(_goodTitleLabel.frame), CGRectGetWidth(_goodTitleLabel.frame) , 18);
    _characterLabel.font = [UIFont systemFontOfSize:11];
    _characterLabel.textColor = [UIColor lightGrayColor];
//    _characterLabel.text = @"颜色：薄荷绿  尺码：170/92A";
    [self.contentView addSubview:_characterLabel];
    
    
    _priceLabel = [[UILabel alloc]init];
    _priceLabel.frame = CGRectMake(CGRectGetMaxX(_goodImageV.frame) + 10, CGRectGetMaxY(_goodImageV.frame) - 25, 100 , 20);
    _priceLabel.font = [UIFont systemFontOfSize:13];
    _priceLabel.textColor = [UIColor redColor];
//    _priceLabel.text = @"¥ 329.00";
    [self.contentView addSubview:_priceLabel];
}
- (void)setCartModel:(CartModel *)cartModel{
    _cartModel = cartModel;
    if (!_isNeedHidden) {
        if (cartModel.isSelected) {
            [_selectBtn setBackgroundImage:[UIImage imageNamed:@"reg_checked"] forState:(UIControlStateNormal)];
        }else{
            [_selectBtn setBackgroundImage:[UIImage imageNamed:@"reg_unchecked"] forState:(UIControlStateNormal)];
        }
        _selectBtn.hidden = NO;
    }else{
        _selectBtn.hidden = YES;
    }
    NSString *imageUrl = cartModel.goodImageUrl;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.jpg",imageUrl]];
    if (!image) {
        image = [UIImage imageNamed:@"list_item_icon"];
    }
    _goodImageV.image = image;
    if ([cartModel.goodsName isEqualToString:@"(null)"] || cartModel.goodsName == nil) {
        
    }else{
        _goodTitleLabel.text = cartModel.goodsName;
    }
    if ([cartModel.goodCharater isEqualToString:@"(null)"] || cartModel.goodCharater == nil) {
        
    }else{
        _characterLabel.text = cartModel.goodCharater;
    }
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",cartModel.price];
}

- (void)selectACtion:(UIButton *)sender{
    
    if (_cartModel.isSelected) {
         [_selectBtn setBackgroundImage:[UIImage imageNamed:@"reg_unchecked"] forState:(UIControlStateNormal)];
        _cartModel.isSelected = NO;
    }else{
         [_selectBtn setBackgroundImage:[UIImage imageNamed:@"reg_checked"] forState:(UIControlStateNormal)];
        _cartModel.isSelected = YES;
    }
    [CartDao updateCartInfo:_cartModel];
    _selectedBlock(_cartModel.isSelected);
}

- (NSString *)getImage{
    NSString *cache = [self cachePath];
    NSString *fullPath = [cache stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",self.imei]];
    return fullPath;
}
- (NSString *)cachePath{
    NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    return cachePath;
}
@end
