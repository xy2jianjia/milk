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

@end

@implementation HomeViewController

static NSString * const reuseIdentifier = @"Cell";
- (void)confiCustomDisplay{
    self.navigationItem.title = @"首页";
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self confiCustomDisplay];
    [self.collectionView registerClass:[HomeViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HomeViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor colorWithRed:indexPath.item * (arc4random() % 9 * 0.01) green:indexPath.item * (arc4random() % 9 * 0.01) blue:indexPath.item * (arc4random() % 9 * 0.01) alpha:1];
    
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = (SCREEN_WIDTH - 20)/2;
    CGFloat height = width + 40+ 20 + 5;
    return CGSizeMake(width, height);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

@end
