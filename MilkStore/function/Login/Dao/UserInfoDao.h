//
//  UserInfoDao.h
//  MilkStore
//
//  Created by monan on 2017/4/10.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DBManager.h"

@interface UserInfoDao : DBManager
/**
 *  用户是否存在
 *
 *  @param userId userId
 *
 *  @return BOOL
 */
+ (BOOL) checkUserWithUsertId:(NSString *)userId;
/**
 保存用户信息
 
 @param item UserInfoModel
 */
+ (void) saveUserInfo:(UserInfoModel *)item;
/**
 *  获取某人数据
 *
 *  @param userId userId
 *
 *  @return UserInfoModel
 */
+ (UserInfoModel *)getUserInfoWithPhoneUDID:(NSString *)udid;

/**
 根据userName查询用户信息

 @param userName
 @return 
 */
+ (UserInfoModel *)getUserInfoWithUserName:(NSString *)userName;

/**
 更新用户信息

 @param item 
 */
+ (void)updateUserInfo:(UserInfoModel *)item;
+ (UserInfoModel *)getUserInfoWithUserId:(NSInteger )userId;
@end
