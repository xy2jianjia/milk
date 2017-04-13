//
//  HttpOperation.h
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpOperation : NSObject
+ (void)asyncGetTokenWithUserInfo:(UserInfoModel *)userInfo completed:(void(^)(NSString *token ,NSInteger code,NSString *msg))completed;
@end
