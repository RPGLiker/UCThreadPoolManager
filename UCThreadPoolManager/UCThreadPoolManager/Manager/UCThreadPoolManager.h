//
//  UCThreadPoolManager.h
//  UCThreadPoolManager
//
//  Created by 范杨 on 2018/7/15.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UCThreadPoolManager : NSObject

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
+ (instancetype)sharedInstance;
+ (BOOL)releaseManager;

- (BOOL)createGCDQueuePoolWithCPUCore;
- (BOOL)createGCDQueuePoolWithCount:(NSInteger)count;
- (dispatch_queue_t)getIdleGCDQueue;

- (BOOL)createNSOperationQueuePoolWithCPUCore;
- (BOOL)createNSOperationQueuePoolWithCount:(NSInteger)count;
- (NSOperationQueue *)getIdleNSOperationQueue;


@end
