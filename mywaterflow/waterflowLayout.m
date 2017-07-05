//
//  waterflowLayout.m
//  mywaterflow
//
//  Created by 刘文强 on 2017/7/5.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "waterflowLayout.h"

@interface waterflowLayout ()
/**
 列数
 */
@property(nonatomic, assign) CGFloat colsNum;

@property(nonatomic,assign) CGFloat  columMargin;

@property(nonatomic,assign) CGFloat  rowMargin;

@property(nonatomic,assign) UIEdgeInsets  edgeInsets;

@property(nonatomic,strong) NSMutableArray * columHeightArr;

@property(nonatomic,strong) NSMutableArray * attributeArr;

@end

@implementation waterflowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    for (int index = 0; index < self.colsNum; index++) {
    
        self.columHeightArr[index] = @(self.edgeInsets.top);
    }
    
    CGFloat totalW = self.collectionView.bounds.size.width;
    
    CGFloat itemW = (totalW - self.edgeInsets.left - self.edgeInsets.right - (self.colsNum - 1)* self.columMargin)/self.colsNum;
    
    NSInteger totalItemNum = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < totalItemNum; i ++) {
        
        NSInteger currentCol = [self getMinHeightCol];
        CGFloat itemX = self.edgeInsets.left + (itemW + self.columMargin) * currentCol;
        CGFloat itemY = [self.columHeightArr[currentCol] floatValue];
        
        NSIndexPath * indexpatch = [NSIndexPath indexPathForItem:i inSection:0];
        
        CGFloat headerviewheight = 0.0;
        if (self.delegate && [self.delegate respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
            headerviewheight = [self.delegate collectviewLayout:self heightForSupplementaryViewAtIndexPath:indexpatch];
        }
        
        if (itemY == self.edgeInsets.top) {
            itemY += headerviewheight;
        }
        CGFloat itemH = 0.0;
        if (self.delegate && [_delegate respondsToSelector:@selector(itemheightLayout:indexpath:)]) {
              itemH =   [_delegate itemheightLayout:self indexpath:indexpatch];
        }
        
        CGRect frame = CGRectMake(itemX, itemY, itemW, itemH);
        
        UICollectionViewLayoutAttributes * atterbute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpatch];
        atterbute.frame = frame;
        [self.attributeArr addObject:atterbute];
        
        
        CGFloat updateY = [self.columHeightArr[currentCol] floatValue] + itemH + self.rowMargin;
        self.columHeightArr[currentCol] = @(updateY);
        NSLog(@"=====%lf====",updateY);
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
//    NSMutableArray * result = [NSMutableArray array];
//    for (UICollectionViewLayoutAttributes * attri in self.attributeArr) {
//        CGRect rect1 = attri.frame;
//        if (CGRectIntersectsRect(rect1, rect)) {
//            [result addObject:attri];
//        }
//    }
//    return result;
    
    /**
     *  计算组头高度
     */
    NSArray *indexPaths = [self indexPathForSupplementaryViewsOfKind:UICollectionElementKindSectionHeader InRect:rect];
    for(NSIndexPath *indexPath in indexPaths){
        
        /**
         *  计算对应的LayoutAttributes
         */
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                            atIndexPath:indexPath];
        [self.attributeArr addObject:attributes];
    }
    
    return self.attributeArr;

}

/**
 *  计算目标rect中含有的某类SupplementaryView
 */
- (NSMutableArray<NSIndexPath *> *)indexPathForSupplementaryViewsOfKind:(NSString *)kind InRect:(CGRect)rect
{
    NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        
        /**
         *  在这个瀑布流自定义布局中，只有一个位于列表顶部的SupplementaryView
         */
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
        
        /**
         *  如果当前区域可以看到SupplementaryView，则返回
         */
        [indexPaths addObject:indexPath];
    }
    return indexPaths;
}

/**
 headerview
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * atter = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        CGFloat w = self.collectionView.frame.size.width;
        CGFloat h = [self.delegate collectviewLayout:self heightForSupplementaryViewAtIndexPath:indexPath];
        CGFloat x = 0;
        CGFloat y = 0;
        atter.frame = CGRectMake(x, y, w, h);
    }
    return atter;
}

- (CGSize)collectionViewContentSize
{
    CGFloat width = self.collectionView.frame.size.width;
    NSInteger index = [self getMaxHeightCol];
    CGFloat height = [self.columHeightArr[index] floatValue];
    return CGSizeMake(width, height);
}

- (CGFloat)getMaxHeightCol
{
    __block CGFloat maxheight =  0.0;
    __block CGFloat maxcol = 0;
    [self.columHeightArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat temp = [self.columHeightArr[idx] floatValue];
        if (maxheight < temp) {
            maxheight = temp;
            maxcol = idx;
        }
    }];
    
    return maxcol;
}

- (CGFloat)getMinHeightCol
{
    __block CGFloat minheight =  MAXFLOAT;
    __block CGFloat mincol = 0;
    [self.columHeightArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat temp = [self.columHeightArr[idx] floatValue];
        if (minheight > temp) {
            minheight = temp;
            mincol = idx;
        }
    }];
    
    return mincol;
}





- (CGFloat)colsNum
{
    if ([self.delegate respondsToSelector:@selector(columCountInLayout:)]) {
        return  [self.delegate columCountInLayout:self];
    }
    return 2;
}
- (CGFloat)columMargin
{
    if ([self.delegate respondsToSelector:@selector(colunMarginInLayout:)]) {
        return  [self.delegate colunMarginInLayout:self];
    }
    return 10;
}
- (CGFloat)rowMargin
{
    if ([self.delegate respondsToSelector:@selector(rowMariginInLayout:)]) {
        return  [self.delegate rowMariginInLayout:self];
    }
    return 10;
}
- (UIEdgeInsets)edgeInsets
{
    if ([self.delegate respondsToSelector:@selector(edgeinsetsInLayout:)]) {
        return  [self.delegate edgeinsetsInLayout:self];
    }
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (NSMutableArray *)columHeightArr {
    if (!_columHeightArr) {
        _columHeightArr = [NSMutableArray array];
    }
    return _columHeightArr;
}
- (NSMutableArray *)attributeArr {
    if (!_attributeArr) {
        _attributeArr = [NSMutableArray array];
    }
    return _attributeArr;
}

@end
