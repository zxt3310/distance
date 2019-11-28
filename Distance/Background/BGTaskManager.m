//
//  BGTaskManager.m
//  Distance
//
//  Created by zhangxintao on 2019/11/15.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "BGTaskManager.h"
#import "DisLocationManager.h"

@interface BGTaskManager ()
@property (nonatomic,strong) NSMutableArray *bgTaskIdList;///<后台任务数组
@property (assign) UIBackgroundTaskIdentifier  masterTaskId;///<当前后台任务ID
@end

@implementation BGTaskManager

static BGTaskManager *manager = nil;

+ (instancetype)defaultManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bgTaskIdList = [NSMutableArray array];
        self.masterTaskId = UIBackgroundTaskInvalid;
    }
    return self;
}

//开启后台任务

- (UIBackgroundTaskIdentifier)beginNewBackgroundTask{
    UIApplication *application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTaskId = UIBackgroundTaskInvalid;
    
    if([application respondsToSelector:@selector(beginBackgroundTaskWithExpirationHandler:)])
    {
        bgTaskId = [application beginBackgroundTaskWithExpirationHandler:^{
            NSLog(@"bgTask 过期 %lu",(unsigned long)bgTaskId);
            [DisLog Write:[NSString stringWithFormat:@"bgTask 过期 %lu,重启后台任务",(unsigned long)bgTaskId] To:LOG_Weakup];
//            [self.bgTaskIdList removeObject:@(bgTaskId)];//过期任务从后台数组删除
            bgTaskId = UIBackgroundTaskInvalid;
            [application endBackgroundTask:bgTaskId];
            //[self endBackGroundTask:NO];
            [[DisLocationManager sharedManager] applicationEnterBackground];
        }];
        
        NSLog(@"开启新任务  %lu",(unsigned long)bgTaskId);
    }
//    //如果上次记录的后台任务已经失效了，就记录最新的任务为主任务
//    if (_masterTaskId == UIBackgroundTaskInvalid) {
//        self.masterTaskId = bgTaskId;
//        NSLog(@"开启后台任务 %lu",(unsigned long)bgTaskId);
//        [DisLog Write:[NSString stringWithFormat:@"开启  后台任务 %lu",(unsigned long)bgTaskId] To:LOG_Weakup];
//    }
//    else //如果上次开启的后台任务还未结束，就提前关闭了，使用最新的后台任务
//    {
//        //add this id to our list
//        NSLog(@"保持  后台任务 %lu", (unsigned long)bgTaskId);
//        [self.bgTaskIdList addObject:@(bgTaskId)];
//        [DisLog Write:[NSString stringWithFormat:@"保持  后台任务 %lu",(unsigned long)bgTaskId] To:LOG_Weakup];
//        //[self endBackGroundTask:NO];//留下最新创建的后台任务
//    }
    
    return bgTaskId;
}

//关闭后台任务
-(void)endBackGroundTask:(BOOL)all
{
    UIApplication *application = [UIApplication sharedApplication];
    //如果为all 清空后台任务数组
    //不为all 留下数组最后一个后台任务,也就是最新开启的任务
    if ([application respondsToSelector:@selector(endBackGroundTask:)]) {
        for (int i = 0; i < (all ? _bgTaskIdList.count :_bgTaskIdList.count -1); i++) {
            UIBackgroundTaskIdentifier bgTaskId = [self.bgTaskIdList[0] integerValue];
            NSLog(@"关闭后台任务 %lu",(unsigned long)bgTaskId);
            [application endBackgroundTask:bgTaskId];
            [self.bgTaskIdList removeObjectAtIndex:0];
        }
    }
    ///如果数组大于0 所有剩下最后一个后台任务正在跑
    if(all){
        [application endBackgroundTask:self.masterTaskId];
        self.masterTaskId = UIBackgroundTaskInvalid;
    }
}



@end
