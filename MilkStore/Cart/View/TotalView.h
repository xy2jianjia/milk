//
//  TotalView.h
//  MilkStore
//
//  Created by monan on 2017/4/11.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CountBlock)();
typedef void(^SelectAllBlock)();
@interface TotalView : UIView
@property (nonatomic,strong) CountBlock countBlock;
@property (nonatomic,strong) SelectAllBlock selectAllBlock;

+ (TotalView *)configBottomViewCountBlock:(CountBlock )countBlock selectAllBlock:(SelectAllBlock)selectAllBlock;
- (void)setTotalMoney:(CGFloat )totalMoney;
@end
