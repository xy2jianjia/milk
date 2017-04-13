//
//  SaveOrderView.h
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SaveOrderBlock)();

@interface SaveOrderView : UIView
@property (nonatomic,strong) SaveOrderBlock saveOrderBlock;
+ (SaveOrderView *)configBottomViewSaveOrderBlock:(SaveOrderBlock)saveOrderBlock;
@end
