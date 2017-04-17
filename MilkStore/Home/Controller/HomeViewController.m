//
//  HomeViewController.m
//  MilkStore
//
//  Created by monan on 2017/2/27.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewCell.h"

@interface HomeViewController ()

@property(nonatomic,strong) NSMutableArray *dataSource;


@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"Cell";
- (void)confiCustomDisplay{
    self.navigationItem.title = @"首页";
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}
- (void)sdCycleScrollView{
    CGRect temp = CGRectMake(0, 64, SCREEN_WIDTH, 150);
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger index = 0; index < 11; index ++) {
        NSString *name = [NSString stringWithFormat:@"Snip20170413_%02ld.png",index + 1];
        UIImage *image = [UIImage imageNamed:name];
        [arr addObject:image];
    }
    SDCycleScrollView *scv = [SDCycleScrollView cycleScrollViewWithFrame:temp imageNamesGroup:arr];
    scv.autoScrollTimeInterval = 5.0f;
    [self.view addSubview:scv];
    CGRect tempRect = self.collectionView.frame ;
    tempRect.origin.y = CGRectGetMaxY(temp) -64;
    tempRect.size.height = SCREEN_HEIGHT  - 150 - 40;
    self.collectionView.frame = tempRect ;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confiCustomDisplay];
    [self sdCycleScrollView];
    [self.collectionView registerClass:[HomeViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self configDataSource];
}
- (void)configDataSource{
    _dataSource = [DataSource getAllData];
    [self.collectionView reloadData];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return _dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    GoodInfoModel *item = [_dataSource objectAtIndex:indexPath.item];
    cell.goodInfoModel = item;
    cell.addGoodsToCartBlock = ^(GoodInfoModel *goodInfoModel) {
        [self showHudInView:self.view hint:@"请稍候.."];
        [self addtoCartWithModel:goodInfoModel];
    };
    return cell;
}
- (void)addtoCartWithModel:(GoodInfoModel *)goodInfoModel{
    UserInfoModel *userInfo = [UserInfoDao getUserInfoWithUserId:self.userId];
    CartModel *item = [[CartModel alloc]init];
    item.cartId = [self uuid];
    item.goodCharater = goodInfoModel.charater;
    item.goodsName = goodInfoModel.name;
    item.goodsId = goodInfoModel.id;
    item.goodImageUrl = goodInfoModel.image;
    
    item.price = goodInfoModel.price;
    item.count = 1;
    item.userId = userInfo.userId;
    item.udid = self.imei;
    
    [CartDao saveCartInfo:item userId:userInfo.userId];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"setCartBadgeValue" object:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self hideHud];
        [self showHint:@"已添加到购物车"];
    });
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
    GoodInfoModel *item = [_dataSource objectAtIndex:indexPath.item];
    vc.goodModel = item;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH - 20)/2;
    CGFloat height = width + 40+ 20 + 5;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
