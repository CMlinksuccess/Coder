//
//  NSObject+Addition.m
//  runtime
//
//  Created by ECOOP on 2018/2/27.
//  Copyright © 2018年 SF. All rights reserved.
//

#import "NSObject+Coder.h"

#define DefaultKeyedArchiverPath [NSString stringWithFormat:@"%@/Documents/DefaultKeyedArchiver.data", NSHomeDirectory()]


@implementation NSObject (Coder)

/**
 *  归档
 *
 *  @param obj 需要归档的类
 *  @param key 归档key
 *
 *  @return YES表示成功，NO表示失败
 */
+(BOOL)keyedArchiver:(id)obj key:(NSString *)key
{
    return [self keyedArchiver:obj key:key path:DefaultKeyedArchiverPath];
}

/**
 *  归档
 *
 *  @param obj  需要归档的类
 *  @param key  归档key
 *  @param path 归档路劲
 *
 *  @return YES表示归档成功，NO表示归档失败
 */
+(BOOL)keyedArchiver:(id)obj key:(NSString *)key path:(NSString *)path
{
    NSMutableData *tpData = [NSMutableData data];
    NSKeyedArchiver *keyedArchiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:tpData];
    [keyedArchiver encodeObject:obj forKey:key];
    [keyedArchiver finishEncoding];
    return [tpData writeToFile:path atomically:YES];
}

/**
 *  解档
 *
 *  @param key key
 *
 *  @return 解析的结果
 */
+(id)keyedUnarchiver:(NSString *)key
{
    return [self keyedUnarchiver:key path:DefaultKeyedArchiverPath];
}

/**
 *  解档
 *
 *  @param key  解挡key
 *  @param path 解挡路径
 *
 *  @return 解析的结果
 */
+(id)keyedUnarchiver:(NSString *)key path:(NSString *)path
{
    NSMutableData *tpData = [NSMutableData dataWithContentsOfFile:path];
    NSKeyedUnarchiver *keyedUnarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:tpData];
    return [keyedUnarchiver decodeObjectForKey:key];
}

@end
