//
//  DataSource.h
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataSource : NSObject

/**
 获取所有商品

 @return
 */
+ (NSMutableArray *)getAllData;

/**
 根据id查询商品

 @param goodId
 @return
 */
+ (GoodInfoModel *)getGoodInfoWithGoodId:(NSInteger)goodId;

/**
 获取分类

 @param name
 @return 
 */
+ (NSMutableArray *)getCatagoryWithName:(NSString *)name;
@end
