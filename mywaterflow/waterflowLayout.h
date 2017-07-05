//
//  waterflowLayout.h
//  mywaterflow
//
//  Created by 刘文强 on 2017/7/5.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <UIKit/UIKit.h>
@class waterflowLayout;
@protocol waterFlowLayoutDelegate <NSObject>

@required
/**
 item.size
 */
- (CGFloat)itemheightLayout:(waterflowLayout *)layout indexpath:(NSIndexPath *)indexpath;

@optional
- (CGFloat)columCountInLayout:(waterflowLayout *)layout;
- (CGFloat)colunMarginInLayout:(waterflowLayout *)layout;
- (CGFloat)rowMariginInLayout:(waterflowLayout *)layout;
- (UIEdgeInsets)edgeinsetsInLayout:(waterflowLayout *)layout;
/**
 headerview
 */
- (CGFloat)collectviewLayout:(waterflowLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath;

@end
@interface waterflowLayout : UICollectionViewFlowLayout

@property(nonatomic,weak)  id<waterFlowLayoutDelegate> delegate;

@end
