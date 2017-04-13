//
//  PersonalHeaderCell.h
//  MilkStore
//
//  Created by monan on 2017/3/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalHeaderCell : UITableViewCell
@property (nonatomic,strong) UserInfoModel *userInfo;
@property (nonatomic,assign) BOOL hideLabel;
-(void)setUserInfo:(UserInfoModel *)userInfo;
@end
