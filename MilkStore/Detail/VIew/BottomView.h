//
//  BottomView.h
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CollectionBlock)(BOOL flag);
typedef void(^CartBlock)(BOOL flag);
typedef void(^BuyBlock)(BOOL flag);
@interface BottomView : UIView

@property (nonatomic,strong) CollectionBlock collectionBlock;
@property (nonatomic,strong) CartBlock cartBlock;
@property (nonatomic,strong) BuyBlock buyBlock;

+ (void)configBottomViewWithCollectionBlock:(CollectionBlock )collectionBlock cartBlock:(CartBlock)cartBlock buyBlock:(BuyBlock )buyBlock;
+ (void)hideBottomView;
+ (void)showBottomView;
@end
