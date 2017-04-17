//
//  BmobDB.m
//  MilkStore
//
//  Created by monan on 2017/4/17.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "BmobDB.h"

@implementation BmobDB
+ (BmobDB *)shareInstance{
    static BmobDB *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[BmobDB alloc]init];
    });
    return instance;
}
- (BmobObject *)getTable{
    BmobObject *gameScore = [BmobObject objectWithClassName:@"UserInfo"];
    return gameScore;
}
+ (void)saveUserInfoToBmob:(UserInfoModel *)userInfo{
    [[BmobDB shareInstance] saveUserInfoToBmob:userInfo];
}
- (void)saveUserInfoToBmob:(UserInfoModel *)userInfo{
    BmobObject *gameScore = [self getTable];
    [gameScore setObject:[NSNumber numberWithInteger:userInfo.userId] forKey:@"userId"];
    [gameScore setObject:userInfo.userName forKey:@"userName"];
    [gameScore setObject:userInfo.password forKey:@"password"];
    [gameScore setObject:userInfo.headerImageUrl forKey:@"headerImageUrl"];
    [gameScore setObject:userInfo.nickName forKey:@"nickName"];
    [gameScore setObject:self.imei forKey:@"udid"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        [self saveObjectId:gameScore.objectId];
        
    }];
}
+ (void)updateUserInfo:(UserInfoModel *)userInfo{
    [[BmobDB shareInstance] updateUserInfo:userInfo];
}
- (void)updateUserInfo:(UserInfoModel *)userInfo{
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"UserInfo"];
    [bquery getObjectInBackgroundWithId:self.objectId block:^(BmobObject *object,NSError *error){
        //没有返回错误
        if (!error) {
            //对象存在
            if (object) {
                //创建一条数据，并上传至服务器
                [object setObject:userInfo.userName forKey:@"userName"];
                [object setObject:userInfo.password forKey:@"password"];
                [object setObject:userInfo.headerImageUrl forKey:@"headerImageUrl"];
                [object setObject:userInfo.nickName forKey:@"nickName"];
                [object setObject:self.imei forKey:@"udid"];
                [object updateInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
                    
                }];
            }
        }
    }];
    
    
}
+ (void)getUserInfoWithUserName:(NSString *)userName completed:(void(^)(UserInfoModel *userInfo))completed{
    [[BmobDB shareInstance] getUserInfoWithUserName:userName completed:completed];
}
- (void)getUserInfoWithUserName:(NSString *)userName completed:(void(^)(UserInfoModel *userInfo))completed{
    //查找GameScore表
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"UserInfo"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (array.count == 0) {
            completed(nil);
        }else{
            UserInfoModel *userInfo = nil;
            for (BmobObject *object in array) {
                NSString *userName1 = [object objectForKey:@"userName"];
                if ([userName1 isEqualToString:userName]) {
                    userInfo = [[UserInfoModel alloc]init];
                    userInfo.userId = [[object objectForKey:@"userId"] integerValue];
                    userInfo.userName = [object objectForKey:@"userName"];
                    userInfo.nickName = [object objectForKey:@"nickName"];
                    userInfo.headerImageUrl = [object objectForKey:@"headerImageUrl"];
                    userInfo.password = [object objectForKey:@"password"];
                    break;
                }
            }
            completed(userInfo);
        }
    }];
    //查找GameScore表里面id为0c6db13c的数据
    [bquery getObjectInBackgroundWithId:self.objectId block:^(BmobObject *object,NSError *error){
        if (error){
            //进行错误处理
            completed(nil);
        }else{
            //表里有id为0c6db13c的数据
            if (object) {
                UserInfoModel *userInfo = [[UserInfoModel alloc]init];
                userInfo.userId = [[object objectForKey:@"userId"] integerValue];
                userInfo.userName = [object objectForKey:@"userName"];
                userInfo.nickName = [object objectForKey:@"nickName"];
                userInfo.headerImageUrl = [object objectForKey:@"headerImageUrl"];
                userInfo.password = [object objectForKey:@"password"];
                completed(userInfo);
            }
        }
    }];
}
+ (void)saveFile:(NSString *)filePath{
    [[BmobDB shareInstance] saveFile:filePath];
}
- (void)saveFile:(NSString *)filePath{
    __weak typeof(&*self) weakSelf = self;
    BmobObject *gameScore = [self getTable];
    BmobFile *file1 = [[BmobFile alloc] initWithFilePath:filePath];
    [file1 saveInBackground:^(BOOL isSuccessful, NSError *error) {
        //如果文件保存成功，则把文件添加到filetype列
        if (isSuccessful) {
            [gameScore setObject:file1.url  forKey:@"headerImageUrl"];
            UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserId:self.userId];
            userInfo.headerImageUrl = file1.url;
            [weakSelf updateUserInfo:userInfo];
            [UserInfoDao updateUserInfo:userInfo];
        }
    }];
}
@end
