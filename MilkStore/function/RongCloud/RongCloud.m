//
//  RongCloud.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "RongCloud.h"

@interface RongCloud ()<RCIMUserInfoDataSource>

@end

@implementation RongCloud

+ (RongCloud *)shareInstance{
    static dispatch_once_t onceToken;
    static RongCloud *cloud = nil;
    dispatch_once(&onceToken, ^{
        cloud = [[RongCloud alloc]init];
    });
    return cloud;
}

+ (void)initializationRC{
    [[RongCloud shareInstance] initializationRC];
}
- (void)initializationRC{
    [[RCIM sharedRCIM] initWithAppKey:@"vnroth0kvfpgo"];
    [[RCIM sharedRCIM] setUserInfoDataSource:self];
    [self getToken];
}

- (void)getToken{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([token length] > 0) {
        [self connectRCServer];
    }else{
        [HttpOperation asyncGetTokenCompleted:^(NSString *token, NSInteger code, NSString *msg) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
            [self connectRCServer];
        }];
    }
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    
    NSString *userName = @"桂纶镁";
    NSString *imageUrl = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1490622493408&di=82fabd2109363399317ea1265ecef71c&imgtype=0&src=http%3A%2F%2Fmxycsku.qiniucdn.com%2Fgroup5%2FM00%2FB2%2F34%2FwKgBf1VjAmqAIA3mAEqbpeBYMkU52.jpeg";
    RCUserInfo *targetUser = [[RCUserInfo alloc]init];
    targetUser.userId = userId;
    targetUser.name = userName;
    targetUser.portraitUri = imageUrl;
    completion(targetUser);
}


+ (void)connectRCServer{
    [[RongCloud shareInstance] connectRCServer];
}
- (void)connectRCServer{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
    [[RCIM sharedRCIM] connectWithToken:token success:^(NSString *userId) {
        NSLog(@"登陆成功。当前登录的用户ID：%@", userId);
    } error:^(RCConnectErrorCode status) {
        NSLog(@"登陆的错误码为:%d", status);
    } tokenIncorrect:^{
        //token过期或者不正确。
        //如果设置了token有效期并且token过期，请重新请求您的服务器获取新的token
        //如果没有设置token有效期却提示token错误，请检查您客户端和服务器的appkey是否匹配，还有检查您获取token的流程。
        NSLog(@"token错误");
    }];
}

@end
