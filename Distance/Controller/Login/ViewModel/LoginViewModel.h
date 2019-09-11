//
//  LoginViewModel.h
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DISUserInfo.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^logRes)(NSString *userId);
@interface LoginViewModel : NSObject

@property logRes resblock;

- (void)starLogin;
@end

NS_ASSUME_NONNULL_END
