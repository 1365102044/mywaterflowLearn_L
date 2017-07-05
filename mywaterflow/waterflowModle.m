//
//  waterflowModle.m
//  mywaterflow
//
//  Created by 刘文强 on 2017/7/5.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "waterflowModle.h"

@implementation waterflowModle
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    NSLog(@"++++++模型中不存在的键值对：value:%@\nkey:%@",value,key);
    
}

- (float)descHeight
{
    return  60;
}
- (float)contentHeight
{
    return  _imageHeight + _descHeight;
}
@end
/**
 当使用setValuesForKeysWithDictionary:方法时，对于数据模型中缺少的、不能与任何键配对的属性的时候，系统会自动调用setValue:forUndefinedKey:这个方法，该方法默认的实现会引发一个NSUndefinedKeyExceptiony异常。
 如果想要程序在运行过程中不引发任何异常信息且正常工作，可以让数据模型类重写setValue:forUndefinedKey:方法以覆盖默认实现，而且可以通过这个方法的两个参数获得无法配对键值。
 */
