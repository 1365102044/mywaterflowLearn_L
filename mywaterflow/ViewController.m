//
//  ViewController.m
//  mywaterflow
//
//  Created by 刘文强 on 2017/7/5.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "ViewController.h"
#import "waterflowModle.h"
#import "waterflowLayout.h"
#import "waterflowCollectionViewCell.h"
#import <SDWebImage/SDImageCache.h>

static NSString * TESTURL = @"http://apis.guokr.com/handpick/article.json?limit=20&ad=1&category=all&retrieve_type=by_since";
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource, waterFlowLayoutDelegate>

@property(nonatomic, nonnull) NSMutableArray * dataArr;
@property(nonatomic,strong) UICollectionView * collectView;
@property(nonatomic,strong) waterflowLayout * layout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"TEST";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectView];
    [self loadTestJson];
    
}
/**
 加载json
 */
- (void)loadTestJson
{
    NSString * str = [NSString stringWithFormat:@"http://apis.guokr.com/handpick/article.json?limit=20&ad=1&category=all&retrieve_type=by_since"];
    NSURL * url = [NSURL URLWithString: str];
    NSURLRequest * quest = [NSURLRequest requestWithURL:url];
    NSURLSessionDataTask * task = [[NSURLSession sharedSession] dataTaskWithRequest:quest
                                                                  completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {

                                                                      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data
                                                                                                                           options:NSJSONReadingMutableContainers
                                                                                                                             error:nil];
                  
                                                                      NSLog(@"%@",dict);
       
                                                                      for (NSDictionary * dic in  [dict objectForKey:@"result"]) {
                                                                          waterflowModle * modle = [[waterflowModle alloc]init];
                                                                          [modle setValuesForKeysWithDictionary:dic];
                                                                          
                                                                          UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:modle.headline_img]]];

                                                                          modle.imageHeight =  image.size.height * (self.view.bounds.size.width / image.size.width);
                                                                          
                                                                          [self.dataArr addObject:modle];
                                                                      }
                                                                      
                                                                      dispatch_async(dispatch_get_main_queue(), ^{
                                                                          
                                                                          [_collectView reloadData];
                                                                      });
    }];
    
    [task resume];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    waterflowCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.modle = self.dataArr[indexPath.row];
    return cell;
}

/**
 添加header视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * headerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview" forIndexPath:indexPath];
    headerview.backgroundColor = [UIColor grayColor];
    return headerview;
}

/**
 waterflowdelegate
 */
- (CGFloat)itemheightLayout:(waterflowLayout *)layout indexpath:(NSIndexPath *)indexpath
{
    waterflowModle * model = self.dataArr[indexpath.row];
    
    return model.imageHeight + model.descHeight;
}

- (CGFloat)collectviewLayout:(waterflowLayout *)layout heightForSupplementaryViewAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/**
 懒加载
 */
- (UICollectionView *)collectView {
    if (!_collectView) {
        _collectView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.layout];
        _collectView.delegate = self;
        _collectView.dataSource = self;
        [_collectView registerClass:[waterflowCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [_collectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview"];
        _collectView.backgroundColor = [UIColor whiteColor];
    }
    return _collectView;
}

- (waterflowLayout *)layout {
    if (!_layout) {
        _layout = [[waterflowLayout alloc]init];
        _layout.delegate = self;
        _layout.headerReferenceSize = CGSizeMake(self.view.bounds.size.width, 100);
    }
    return _layout;
}


- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataArr;
}
/**
 利息： 1530+1285）*0.0627 = 176
 
  三个月的利息：  176 * 3 = 530
 分期相对季度便宜的服务费：551
 
 季度：1530 *4 + 1836 =   7956
 半年付：省下的服务费（1561） = 275
  退租退换的押金：  459
 
 1530*3
 */

@end
