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
    for (NSInteger index = 0; index < 4; index ++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg",index]];
        [arr addObject:image];
    }
    SDCycleScrollView *scv = [SDCycleScrollView cycleScrollViewWithFrame:temp imageNamesGroup:arr];
    scv.autoScrollTimeInterval = 5.0f;
    [self.view addSubview:scv];
    CGRect tempRect = self.collectionView.frame ;
    tempRect.origin.y = CGRectGetMaxY(temp) - 64;
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
    _dataSource = [NSMutableArray array];
    NSDictionary *temp = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"DataSource" ofType:@"plist"]];
    NSArray *arr = [temp objectForKey:@"drink"];
    for (NSDictionary *dict in arr) {
        GoodInfoModel *item = [[GoodInfoModel alloc]init];
        [item setValuesForKeysWithDictionary:dict];
        [_dataSource addObject:item];
    }
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
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DetailViewController *vc = [[DetailViewController alloc]initWithStyle:(UITableViewStyleGrouped)];
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
