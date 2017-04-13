//
//  GoodInfoModel.h
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodInfoModel : NSObject

@property (nonatomic,assign) NSInteger id;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *charater;
@property (nonatomic,copy) NSString *image;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,assign) CGFloat price;
@end
