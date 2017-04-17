//
//  BottomView.m
//  MilkStore
//
//  Created by monan on 2017/3/28.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "BottomView.h"

@interface BottomView()

@property (nonatomic,strong) UIButton *collectionBtn;
@property (nonatomic,strong) UIButton *addCartBtn;
@property (nonatomic,strong) UIButton *buyBtn;
@end

@implementation BottomView

+ (BottomView *)shareView{
    static dispatch_once_t onceToken;
    static BottomView *view = nil;
    dispatch_once(&onceToken, ^{
        view = [[BottomView alloc]init];
    });
    return view;
}

+ (void)configBottomViewWithCollectionBlock:(CollectionBlock )collectionBlock cartBlock:(CartBlock)cartBlock buyBlock:(BuyBlock )buyBlock{
    [[BottomView shareView] configBottomViewWithCollectionBlock:collectionBlock cartBlock:cartBlock buyBlock:buyBlock];
}
- (void)configBottomViewWithCollectionBlock:(CollectionBlock )collectionBlock cartBlock:(CartBlock)cartBlock buyBlock:(BuyBlock )buyBlock{
    _collectionBlock = collectionBlock;
    _cartBlock = cartBlock;
    _buyBlock = buyBlock;
    [self configViews];
}
- (void)configViews{
    self.hidden = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
        _collectionBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _collectionBtn.frame = CGRectMake(10, 10, CGRectGetHeight(self.bounds) - 20, CGRectGetHeight(self.bounds) - 20);
//        _collectionBtn.backgroundColor = [UIColor grayColor];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"shopdetail_wangwang"] forState:(UIControlStateNormal)];
        [_collectionBtn addTarget:self action:@selector(collectionBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_collectionBtn];
        
        _addCartBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addCartBtn.frame = CGRectMake(CGRectGetMaxX(_collectionBtn.frame)+5, 0, (SCREEN_WIDTH - 30)/2, CGRectGetHeight(self.bounds));
        [_addCartBtn setTitle:@"加入购物车" forState:(UIControlStateNormal)];
        [_addCartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addCartBtn.backgroundColor = [UIColor orangeColor];
        [_addCartBtn addTarget:self action:@selector(addCartBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_addCartBtn];
        
        _buyBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _buyBtn.frame = CGRectMake(CGRectGetMaxX(_addCartBtn.frame), 0, CGRectGetWidth(_addCartBtn.frame), CGRectGetHeight(self.bounds));
        [_buyBtn setTitle:@"立即购买" forState:(UIControlStateNormal)];
        [_buyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyBtn.backgroundColor = [UIColor redColor];
        [_buyBtn addTarget:self action:@selector(buyBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_buyBtn];
        
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview:self];
    });
}
+ (void)hideBottomView{
    [[BottomView shareView] hideBottomView];
}
- (void)hideBottomView{
    self.hidden = YES;
}
+ (void)showBottomView{
    [[BottomView shareView] showBottomView];
}
- (void)showBottomView{
    self.hidden = NO;
}
- (void)collectionBtnAction{
    _collectionBlock(YES);
}
- (void)addCartBtnAction{
    _cartBlock(YES);
}
- (void)buyBtnAction{
    _buyBlock(YES);
}

@end
