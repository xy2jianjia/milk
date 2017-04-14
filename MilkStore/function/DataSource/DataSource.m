//
//  DataSource.m
//  MilkStore
//
//  Created by monan on 2017/4/14.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "DataSource.h"

@implementation DataSource
+ (DataSource *)shareData{
    static DataSource *data = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        data = [[DataSource alloc]init];
    });
    return data;
}
- (NSDictionary *)data{
    NSDictionary *temp = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataSource" ofType:@"plist"]];
    
    return temp;
}
+ (NSMutableArray *)getAllData{
    return [[DataSource shareData] getAllData];
}
- (NSMutableArray *)getAllData{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSDictionary *temp = [self data];
    for (NSString *key in [temp allKeys]) {
        NSArray *arr = [temp objectForKey:key];
        for (NSDictionary *dict in arr) {
            GoodInfoModel *item = [[GoodInfoModel alloc]init];
            [item setValuesForKeysWithDictionary:dict];
            [dataArr addObject:item];
        }
    }
    return dataArr;
}
+ (GoodInfoModel *)getGoodInfoWithGoodId:(NSInteger)goodId{
    return [[DataSource shareData] getGoodInfoWithGoodId:goodId];
}
- (GoodInfoModel *)getGoodInfoWithGoodId:(NSInteger)goodId{
    NSArray *arr = [self getAllData];
    GoodInfoModel *temp = nil;
    for (GoodInfoModel *item in arr) {
        if (item.id == goodId) {
            temp = item;
            break;
        }
    }
    return temp;
}
+ (NSMutableArray *)getCatagoryWithName:(NSString *)name{
    return [[DataSource shareData] getCatagoryWithName:name];
}
- (NSMutableArray *)getCatagoryWithName:(NSString *)name{
    NSMutableArray *dataArr = [NSMutableArray array];
    NSDictionary *temp = [self data];
    NSArray *arr = [temp objectForKey:name];
    for (NSDictionary *dict in arr) {
        GoodInfoModel *item = [[GoodInfoModel alloc]init];
        [item setValuesForKeysWithDictionary:dict];
        [dataArr addObject:item];
    }
    return dataArr;
}

@end
