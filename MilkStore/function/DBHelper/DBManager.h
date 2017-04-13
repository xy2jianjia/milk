//

//  RCloudMessage
//
//  Created by wjb on 15/6/3.
//  Copyright (c) 2015年 wbj. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface DBManager : NSObject
/**
 *  单例
 *
 *  @return 返回DBManager对象
 */
+ (instancetype)shareInstance;
+ (void)createUserTableWithSQL:(NSString *)sql tableName:(NSString *)tableName;

/**
 *  检测某个字段是否存在，不存在则创建
 *
 *  @param columnName
 *  @param tableName  
 */
+ (void)isColumnExistWithColumnName:(NSString *)columnName tableName:(NSString *)tableName;

@end
