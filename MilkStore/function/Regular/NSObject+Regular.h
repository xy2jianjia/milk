//
//  NSObject+Regular.h
//  IMCHUMO
//
//  Created by xy2 on 16/9/7.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Regular)
/**
 *  微信正则表达式
 *
 *  @param WX
 *
 *  @return 
 */
- (BOOL) validateWX:(NSString *)WX;
/**
 *  qq正则表达式
 *
 *  @param QQ
 *
 *  @return 
 */
- (BOOL) validateQQNUM:(NSString *)QQ;
/**
 *  是否包含汉字
 *
 *  @param str
 *
 *  @return 
 */
- (BOOL)includeChineseWithString:(NSString *)str;
/**
 *  纯数字正则表达式
 *
 *  @param number
 *
 *  @return 
 */
- (BOOL) validateNumber:(NSString *)number;
/**
 *  配置随机数
 *
 *  @param max 最大值
 *  @param min 最小值
 *
 *  @return
 */
- (NSInteger )randomIndexWithMaxNumber:(NSInteger )max min:(NSInteger )min;
/**
 验证邮箱

 @param BOOL

 @return
 */
- (BOOL) validateEmail:(NSString *)email;
/**
 验证手机
 
 @param BOOL
 
 @return
 */
- (BOOL) validateMobile:(NSString *)mobile;
/**
 *  @author zjy
 *
 *  验证密码
 *
 *  @param password
 *
 *  @return 
 */
- (BOOL) validatePassWord:(NSString *)password;

/**
 字符串中的url提取

 @param string
 @return 
 */
- (NSString * )parseURLWithString:(NSString *)string;

/**
 获取手机序列号

 @return
 */
- (NSString *)imei;

/**
 获取uuid

 @return 
 */
- (NSString *)uuid;
- (void)saveUserId:(NSInteger )userId;
- (NSInteger)userId;
@end
