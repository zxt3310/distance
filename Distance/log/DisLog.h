//
//  DisLog.h
//  Distance
//
//  Created by zhangxintao on 2019/11/7.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DisLog : NSObject
+ (BOOL)WriteLocate:(NSString *)log;
+ (BOOL)Write:(NSString *)log To:(NSString *)file;
+ (BOOL)clearLog;
@end

NS_ASSUME_NONNULL_END
