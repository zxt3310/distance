//
//  DISUserInfo.h
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DISUserInfo : NSObject <YYModel,NSSecureCoding>

@property NSString *username;

@property NSString *userid;

+ (instancetype)sharedInfo;

- (void)save;

@end

NS_ASSUME_NONNULL_END
