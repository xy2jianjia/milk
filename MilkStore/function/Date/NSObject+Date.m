//
//  NSObject+Date.m
//  IMCHUMO
//
//  Created by xy2 on 16/9/5.
//  Copyright © 2016年 xy2. All rights reserved.
//

#import "NSObject+Date.h"

@implementation NSObject (Date)
#pragma mark - 日历获取在9.x之后的系统使用currentCalendar会出异常。在8.0之后使用系统新API。
- (NSCalendar *)currentCalendar {
    if ([NSCalendar respondsToSelector:@selector(calendarWithIdentifier:)]) {
        return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    return [NSCalendar currentCalendar];
}
- (NSDateFormatter *)format{
    static dispatch_once_t onceToken;
    static NSDateFormatter *fmt = nil;
    dispatch_once(&onceToken, ^{
        fmt = [[NSDateFormatter alloc]init];
        [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss:sss"];
    });
    return fmt;
}
- (NSDate *)dateFromString:(NSString *)string{
    return [[self format] dateFromString:string];
}
- (NSString *)stringFromDate:(NSDate *)date{
    return [[self format] stringFromDate:date];
}
/**
 *  比较分钟差
 *
 *  @param date1 从哪个时间
 *  @param date2 到哪个时间
 *
 *  @return
 */
- (NSInteger )getLastIntavalTimeWithDate1:(NSDate *)date1 date2:(NSDate *)date2{
    NSCalendar *cal = [self currentCalendar];
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    NSDateComponents *d = [cal components:unitFlags fromDate:date1 toDate:date2 options:0];
    NSInteger intvalMin = [d minute];
    return intvalMin;
}

- (NSDateComponents *)getDelayWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    [fmt setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [fmt dateFromString:startTime];
    NSDate *endDate = [fmt dateFromString:endTime];
    
    NSCalendar *calendar = [self currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    return dateCom;
}
- (NSDateComponents *)V1_getDelayWithStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    NSDate *startDate = [[self format] dateFromString:startTime];
    NSDate *endDate = [[self format] dateFromString:endTime];
    
    NSCalendar *calendar = [self currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth| NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startDate toDate:endDate options:0];
    return dateCom;
}
- (long long)longDateFromString:(NSString *)string{
    NSDate *date = [self dateFromString:string];
    long long interval = [date timeIntervalSince1970];
    return interval;
}
- (NSString *)stringFromLongDate:(long long)longDate{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:longDate];
    return [[self format] stringFromDate:date];
}
@end
