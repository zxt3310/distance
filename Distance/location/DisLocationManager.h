//
//  DisLocationManager.h
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisLocationManager : NSObject
+ (instancetype)sharedManager;
- (void)beginUpdateLocation;
- (void)stopUpdateLocation;
- (void)startLocation;

- (void)applicationEnterBackground;
@end

NS_ASSUME_NONNULL_END
