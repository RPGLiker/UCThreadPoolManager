//
//  ViewController.m
//  UCThreadPoolManager
//
//  Created by 范杨 on 2018/7/15.
//  Copyright © 2018年 RPGLiker. All rights reserved.
//

#import "ViewController.h"
#import "UCThreadPoolManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[UCThreadPoolManager sharedInstance] createGCDQueuePoolWithCPUCore];
    for (int i = 0 ; i < 10; i ++) {
        [self beginTaskWithIndex:i];
    }
}

- (void)beginTaskWithIndex:(int)index{
    dispatch_queue_t queue1 = [[UCThreadPoolManager sharedInstance] getIdleGCDQueue];
    dispatch_async(queue1, ^{
//        NSLog(@"%d------%s",index, dispatch_queue_get_label(queue1));
        NSLog(@"%d------%@",index, [NSThread currentThread]);
        for (int i = 0; i < 10000; i ++) {
            if (i == 9999) {
//                NSLog(@"%d---结束了",index);
            }
        }
    });
}


@end
