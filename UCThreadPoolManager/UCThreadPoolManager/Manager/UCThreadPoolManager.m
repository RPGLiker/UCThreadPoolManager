//
//  UCThreadPoolManager.m
//  UCThreadPoolManager
//
//  Created by 范杨 on 2018/7/15.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "UCThreadPoolManager.h"
#import <sys/sysctl.h>

@interface UCThreadPoolManager()
@property (strong, nonatomic) NSMutableArray<dispatch_queue_t> *queueArray;
@end

@implementation UCThreadPoolManager{
    NSInteger _cpuCoreCount;
    NSInteger _gcdQueueUseTimes;
    NSInteger _operationQueueTimes;
}
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

- (instancetype)init{
    if (self = [super init]) {
        _cpuCoreCount = countOfCores();
        _gcdQueueUseTimes = 0;
        _operationQueueTimes = 0;
    }
    return self;
}

#pragma mark - public

- (BOOL)createGCDQueuePoolWithCPUCore{
    return [self createGCDQueuePoolWithCount:countOfCores()];
}

- (BOOL)createGCDQueuePoolWithCount:(NSInteger)count{
    if (self.queueArray.count > 0) {
        [self releaseQueueArray];
    }
        
    for (int i = 0; i < count; i ++) {
        NSString *queueName = [NSString stringWithFormat:@"GCD_QUEUE_%d",i];
        dispatch_queue_t queue = dispatch_queue_create([queueName UTF8String], DISPATCH_QUEUE_SERIAL);
        [self.queueArray addObject:queue];
    }
    return YES;
}
- (dispatch_queue_t)getIdleGCDQueue{
    NSInteger index = _gcdQueueUseTimes % _cpuCoreCount;
    dispatch_queue_t queue = self.queueArray[index];
    _gcdQueueUseTimes ++;
    return queue;
}

#pragma mark - private
- (void)releaseQueueArray{
    [self.queueArray removeAllObjects];
    self.queueArray = nil;
}

#pragma mark - C Func

/**
 Get CPU core count.
 */
unsigned int countOfCores()
{
    unsigned int ncpu;
    size_t len = sizeof(ncpu);
    sysctlbyname("hw.ncpu", &ncpu, &len, NULL, 0);
    
    return ncpu;
}
#pragma mark - set && get
- (NSMutableArray<dispatch_queue_t> *)queueArray{
    if (!_queueArray) {
        _queueArray = [NSMutableArray array];
    }
    return _queueArray;
}
@end
