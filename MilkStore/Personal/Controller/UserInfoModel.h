//
//  UserInfoModel.h
//  MilkStore
//
//  Created by monan on 2017/3/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoModel : NSObject
@property (nonatomic,assign) NSInteger userId;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *headerImageUrl;
@property (nonatomic,strong) NSString *nickName;
@end
