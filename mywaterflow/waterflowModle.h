//
//  waterflowModle.h
//  mywaterflow
//
//  Created by 刘文强 on 2017/7/5.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface waterflowModle : NSObject
@property (nonatomic,strong)NSString *now; // 发布时间

@property (nonatomic,strong)NSString * headline_img; // 图片URL

@property (nonatomic,strong)NSString * title; // 标题

@property (nonatomic,strong)NSString * source_name; // 来源

@property (nonatomic,strong)NSString * link;

@property (nonatomic,strong)NSString * link_v2; // 详情网址

@property (nonatomic,strong)NSString * summary;  // 简介

@property (nonatomic,strong)NSString * author; // 作者

@property (nonatomic,strong)NSString * category; // 类型

@property(nonatomic,copy) NSString * video_url;


@property(nonatomic,assign) float  imageHeight;

@property(nonatomic,assign) float  contentHeight;

@property(nonatomic,assign) float  descHeight;

@end
