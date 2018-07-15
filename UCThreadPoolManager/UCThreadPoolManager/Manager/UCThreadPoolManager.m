//
//  UCThreadPoolManager.m
//  UCThreadPoolManager
//
//  Created by 范杨 on 2018/7/15.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCThreadPoolManager.h"

@implementation UCThreadPoolManager
static UCThreadPoolManager *_share = nil;
+ (instancetype)sharedInstance{
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        _share = [[super allocWithZone:NULL] init];
    });
    return _share;
}
+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

@end
