//
//  UIViewController+HUD.h
//  XDHoHo
//
//  Created by Li Zhiping on 13-12-21.
//  Copyright (c) 2013年 XD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;
- (void)showNetWoringInView:(UIView *)view hint:(NSString *)hint;
- (void)showNetWoringALLTimeInView:(UIView *)view hint:(NSString *)hint;
@end
