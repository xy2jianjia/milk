//
//  CartDao.h
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DBManager.h"

@interface CartDao : DBManager

/**
 检测是否存在

 @param cartId
 @return
 */
+ (BOOL) checkUserWithCartId:(NSString *)cartId;
/**
 保存到购物车

 @param item
 @param userId 
 */
+ (void) saveCartInfo:(CartModel *)item userId:(NSInteger )userId;
/**
 查询购物车

 @param udid
 @return 
 */
+ (NSMutableArray *)getCartInfoWithPhoneUDID:(NSString *)udid;
/**
 更新购物车某件物品

 @param item 
 */
+ (void)updateCartInfo:(CartModel *)item;

/**
 查询某件物品

 @param cartId
 @return
 */
+ (CartModel *)getCartInfoWithCartId:(NSString *)cartId;
+ (void) deleteCartInfoWithId:(NSString *)cartId;
@end
