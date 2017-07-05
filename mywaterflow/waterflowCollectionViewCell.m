//
//  waterflowCollectionViewCell.m
//  mywaterflow
//
//  Created by 刘文强 on 2017/7/5.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "waterflowCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@interface waterflowCollectionViewCell ()
{
    UIImageView * headimageview;
    UILabel *desclable;
}

@end

@implementation waterflowCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        headimageview = [[UIImageView alloc]init];
        [self.contentView addSubview:headimageview];
        
        desclable = [[UILabel alloc]init];
        desclable.numberOfLines = 0;
        desclable.font = [UIFont systemFontOfSize:13];
        desclable.textColor = [UIColor brownColor];
        [self.contentView addSubview:desclable];
    }
    return self;
}

- (void)setModle:(waterflowModle *)modle
{
    _modle = modle;
    
    [headimageview sd_setImageWithURL:[NSURL URLWithString:modle.headline_img] placeholderImage:nil options:SDWebImageRetryFailed];
    desclable.text = modle.title;
    
    headimageview.frame = CGRectMake(0, 0, self.bounds.size.width, modle.imageHeight);
    desclable.frame = CGRectMake(0, modle.imageHeight, self.bounds.size.width, modle.descHeight);
}
@end
