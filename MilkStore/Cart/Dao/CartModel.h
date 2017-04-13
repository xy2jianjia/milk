//
//  CartModel.h
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CartModel : NSObject
@property (nonatomic,strong) NSString *cartId;
@property (nonatomic,assign) NSInteger goodsId;
@property (nonatomic,strong) NSString *goodsName;
@property (nonatomic,strong) NSString *goodImageUrl;
@property (nonatomic,strong) NSString *goodCharater;
@property (nonatomic,assign) CGFloat price;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,strong) NSString *udid;
@property (nonatomic,assign) BOOL isSelected;
@end
