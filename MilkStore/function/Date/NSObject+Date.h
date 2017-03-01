//
//  NSObject+Date.h
//  IMCHUMO
//
//  Created by xy2 on 16/9/5.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Date)
/**
 *  获取当前日历
 *
 *  @return 
 */
- (NSCalendar *)currentCalendar;
/**
 *  字符转nsdate
 *
 *  @param string
 *
 *  @return 
 */
- (NSDate *)dateFromString:(NSString *)string;
/**
 *  日期转字符
 *
 *  @param date
 *
 *  @return 
 */
- (NSString *)stringFromDate:(NSDate *)date;
/**
 *  比较分钟差
 *
 *  @param date1 从哪个时间
 *  @param date2 到哪个时间
 *
 *  @return
 */
- (NSInteger )getLastIntavalTimeWithDate1:(NSDate *)date1 date2:(NSDate *)date2;
/**
 *  表时间差:yyyy-MM-dd HH:mm:ss
 *
 *  @param startTime
 *  @param endTime   
 *
 *  @return <#return value description#>
 */
- (NSDateComponents *)getDelayWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

/**
 格式化时间转成long long

 @param string
 @return 
 */
- (long long)longDateFromString:(NSString *)string;

/**
 long long类型转成格式化时间

 @param longDate
 @return
 */
- (NSString *)stringFromLongDate:(long long)longDate;
/**
 *  表时间差,yyyy-MM-dd HH:mm:ss:sss
 *
 *  @param startTime
 *  @param endTime
 *
 *  @return <#return value description#>
 */
- (NSDateComponents *)V1_getDelayWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;
@end
