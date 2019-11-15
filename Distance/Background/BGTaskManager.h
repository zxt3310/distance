//
//  BGTaskManager.h
//  Distance
//
//  Created by zhangxintao on 2019/11/15.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BGTaskManager : NSObject
+ (instancetype)defaultManager;
- (UIBackgroundTaskIdentifier)beginNewBackgroundTask;
@end

NS_ASSUME_NONNULL_END
