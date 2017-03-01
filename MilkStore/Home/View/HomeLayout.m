//
//  HomeLayout.m
//  MilkStore
//
//  Created by monan on 2017/3/1.
//  Copyright © 2017年 xy2. All rights reserved.
//

#import "HomeLayout.h"
#define kItemWidth 100

@interface HomeLayout ()
@property (nonatomic,strong) NSMutableArray *attributeAttay;
@end

@implementation HomeLayout

-(void)prepareLayout{
    [super prepareLayout];
    self.attributeAttay = [NSMutableArray array];
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    CGFloat width = (SCREEN_WIDTH - 5)/2;
    CGFloat height = width + 40+ 20;
    float WIDTH = width;
    //定义数组保存每一列的高度
    
    //这个数组的主要作用是保存每一列的总高度，这样在布局时，我们可以始终将下一个Item放在最短的列下面
    
    CGFloat colHight[2]={self.sectionInset.top,self.sectionInset.bottom};
    
    //itemCount是外界传进来的item的个数 遍历来设置每一个item的布局
    
    for (int i=0; i < 100; i++) {
        
//        设置每个item的位置等相关属性
        
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        
//        创建一个布局属性类，通过indexPath来创建
        
        UICollectionViewLayoutAttributes * attris = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:index];
        
//        随机一个高度 在40——190之间
        
        CGFloat hight = height;
        
//        哪一列高度小 则放到那一列下面
//        
//        标记最短的列
        
        int width=0;
        
        if (colHight[0]<colHight[1]) {
            
            //将新的item高度加入到短的一列
            
            colHight[0] = colHight[0]+hight+self.minimumLineSpacing;
            
            width=0;
            
        }else{
            
            colHight[1] = colHight[1]+hight+self.minimumLineSpacing;
            
            width=1;
            
        }
        
        
        
        //设置item的位置
        
        attris.frame = CGRectMake(self.sectionInset.left+(self.minimumInteritemSpacing+WIDTH)*width, colHight[width]-height-self.minimumLineSpacing, WIDTH, hight);
        
        [_attributeAttay addObject:attris];
        
    }
    
    
    
    //设置itemSize来确保滑动范围的正确 这里是通过将所有的item高度平均化，计算出来的(以最高的列位标准)
    
    if (colHight[0]>colHight[1]) {
        
        self.itemSize = CGSizeMake(WIDTH, (colHight[0]-self.sectionInset.top)*2/100-self.minimumLineSpacing);
        
    }else{
        
        self.itemSize = CGSizeMake(WIDTH, (colHight[1]-self.sectionInset.top)*2/100-self.minimumLineSpacing);
        
    }
}

-(CGSize)collectionViewContentSize{
    [super collectionViewContentSize];
    CGFloat width = (SCREEN_WIDTH - 5)/2;
    CGFloat height = width + 40+ 20;
    return CGSizeMake(width, height);
}
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    // 获得super已经计算好的布局属性
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    return array;
}
// 当UICollectionView停止的那一刻ContentOffset的值(控制UICollectionView停止时，有一个Item一定居中显示)
// 1.proposedContentOffset默认的ContentOffset
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    //1. 获取UICollectionView停止的时候的可视范围
    CGRect contentFrame;
    contentFrame.size = self.collectionView.frame.size;
    contentFrame.origin = proposedContentOffset;
    
    NSArray *array = [self layoutAttributesForElementsInRect:contentFrame];
    
    //2. 计算在可视范围的距离中心线最近的Item
    CGFloat minCenterX = CGFLOAT_MAX;
    CGFloat collectionViewCenterX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if(ABS(attrs.center.x - collectionViewCenterX) < ABS(minCenterX)){
            minCenterX = attrs.center.x - collectionViewCenterX;
        }
    }
    
    //3. 补回ContentOffset，则正好将Item居中显示
    return CGPointMake(proposedContentOffset.x + minCenterX, proposedContentOffset.y);
}
@end
