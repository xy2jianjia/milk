//
//  SaveOrderView.m
//  MilkStore
//
//  Created by monan on 2017/4/13.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "SaveOrderView.h"

@interface SaveOrderView ()
@property (nonatomic,strong)UIButton *saveBtn;
@end

@implementation SaveOrderView

+ (SaveOrderView *)shareView{
    static dispatch_once_t onceToken;
    static SaveOrderView *view = nil;
    dispatch_once(&onceToken, ^{
        view = [[SaveOrderView alloc]init];
    });
    return view;
}
+ (SaveOrderView *)configBottomViewSaveOrderBlock:(SaveOrderBlock)saveOrderBlock{
    return [[SaveOrderView shareView] configBottomViewSaveOrderBlock:saveOrderBlock];
}
- (SaveOrderView *)configBottomViewSaveOrderBlock:(SaveOrderBlock)saveOrderBlock{
    _saveOrderBlock = saveOrderBlock;
    self.hidden = NO;
    self.backgroundColor = kUIColorFromRGB(0xffffff);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    
        self.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
        _saveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _saveBtn.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds) , CGRectGetHeight(self.bounds) );
        [_saveBtn setTitle:@"去付款" forState:(UIControlStateNormal)];
        _saveBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_saveBtn setBackgroundColor:[UIColor redColor]];
        [_saveBtn setTitleColor:kUIColorFromRGB(0xffffff) forState:(UIControlStateNormal)];
        [_saveBtn addTarget:self action:@selector(collectionBtnAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:_saveBtn];
        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
        [keyWindow addSubview:self];
    
    });
    
    return self;
}
- (void)collectionBtnAction{
    _saveOrderBlock();
}
@end
