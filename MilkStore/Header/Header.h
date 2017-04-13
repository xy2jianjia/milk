//
//  Header.h
//  MilkStore
//
//  Created by monan on 2017/2/27.
//  Copyright © 2017年 xy2. All rights reserved.
//


#ifndef Header_h
#define Header_h
#ifdef __OBJC__
#import <UIKit/UIKit.h>      //这个是你预编译的文件举例。

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "CartViewController.h"
#import "PersonalViewController.h"
#import "HomeLayout.h"
#import "NSObject+fontSize.h"
#import "NSObject+Date.h"
#import "UIImageView+WebCache.h"
#import <UMSocialCore/UMSocialCore.h>
#import "GoodInfoModel.h"
#import "UserInfoModel.h"
#import "SDCycleScrollView.h"
#import "DetailViewController.h"
#import <RongIMKit/RongIMKit.h>
#import "AFNetworking.h"
#import "HttpOperation.h"
#import "RongCloud.h"
#import "JSONKit.h"
#import "LoginViewController.h"
#import "NSObject+Regular.h"
#import "UserInfoDao.h"
#import "JNKeychain.h"
#import "CartModel.h"
#import "DBHelper.h"
#import "CartDao.h"
#import "UIViewController+HUD.h"
#import "TotalView.h"
#import "OrderModel.h"
#import "OrderDao.h"
#define screenSize [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH  screenSize.width
#define SCREEN_HEIGHT  screenSize.height

#define kUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


static NSString * const BUNDLEID_FOR_KEY = @"com.kuyuechuang.qiuyang";
#endif
#endif /* Header_h */
