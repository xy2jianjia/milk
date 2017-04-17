//
//  RongCloud.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "RongCloud.h"

@interface RongCloud ()<RCIMUserInfoDataSource,RCIMReceiveMessageDelegate>

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
    [[RCIM sharedRCIM] setReceiveMessageDelegate:self];
    [self getToken];
}
-(void)onRCIMReceiveMessage:(RCMessage *)message left:(int)left{
    NSLog(@"%@",message.content);
}
- (void)getToken{
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([token length] > 0) {
        [self connectRCServerWithToken:token];
    }else{
        UserInfoModel *currentUser = [UserInfoDao getUserInfoWithUserId:[self userId]];
        if (!currentUser) {
            NSLog(@"未注册");
            return;
        }
        [HttpOperation asyncGetTokenWithUserInfo:currentUser completed:^(NSString *token, NSInteger code, NSString *msg) {
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
            [self connectRCServerWithToken:token];
        }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        UserInfoModel *turingUser = [UserInfoDao getUserInfoWithUserId:@"1001"];
//        [HttpOperation asyncGetTokenWithUserInfo:turingUser completed:^(NSString *token, NSInteger code, NSString *msg) {
//            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
//            [self connectRCServerWithToken:token];
//        }];
//        
//    });
    
    }
}

- (void)getUserInfoWithUserId:(NSString *)userId completion:(void (^)(RCUserInfo *userInfo))completion{
    
    UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserName:userId];
    if (!userInfo) {
        [BmobDB getUserInfoWithUserName:userId completed:^(UserInfoModel *userInfo1) {
            if (userInfo1) {
                [UserInfoDao saveUserInfo:userInfo1];
                RCUserInfo *targetUser = [[RCUserInfo alloc]init];
                targetUser.userId = [NSString stringWithFormat:@"%@",userInfo1.userName];
                targetUser.name = userInfo1.nickName;
                targetUser.portraitUri = userInfo1.headerImageUrl;
                completion(targetUser);
            }
        }];
    }else{
        RCUserInfo *targetUser = [[RCUserInfo alloc]init];
        targetUser.userId = [NSString stringWithFormat:@"%@",userInfo.userName];
        targetUser.name = userInfo.nickName;
        targetUser.portraitUri = userInfo.headerImageUrl;
        completion(targetUser);
    }
    
    
    
}


+ (void)connectRCServerWithToken:(NSString *)token{
    [[RongCloud shareInstance] connectRCServerWithToken:token];
}
- (void)connectRCServerWithToken:(NSString *)token{
    
//    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    
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
