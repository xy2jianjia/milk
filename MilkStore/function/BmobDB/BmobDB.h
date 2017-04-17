//
//  BmobDB.h
//  MilkStore
//
//  Created by monan on 2017/4/17.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BmobDB : NSObject
/**
 保存用户信息
 
 @param userInfo
 */
+ (void)saveUserInfoToBmob:(UserInfoModel *)userInfo;

/**
 更新数据
 
 @param userInfo <#userInfo description#>
 */
+ (void)updateUserInfo:(UserInfoModel *)userInfo;

/**
 获取用户信息
 
 @param completed <#completed description#>
 */
+ (void)getUserInfoWithUserName:(NSString *)userName completed:(void(^)(UserInfoModel *userInfo))completed;

/**
 保存文件
 
 @param filePath <#filePath description#>
 */
+ (void)saveFile:(NSString *)filePath;
@end
