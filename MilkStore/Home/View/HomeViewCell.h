//
//  HomeViewCell.h
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodInfoModel.h"

typedef void(^AddGoodsToCartBlock)(GoodInfoModel *goodInfoModel);

@interface HomeViewCell : UICollectionViewCell

@property (nonatomic,strong) GoodInfoModel *goodInfoModel;
@property (nonatomic,strong) AddGoodsToCartBlock addGoodsToCartBlock;
@end
