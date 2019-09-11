//
//  LoginViewModel.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "LoginViewModel.h"
#import "DisLoginReqest.h"


@implementation LoginViewModel

- (void)starLogin{
    DisLoginReqest *req = [[DisLoginReqest alloc] initWithParam:[DISUserInfo sharedInfo]];
    [req startRequest];
    
    __weak typeof(self) weakSelf = self;
    req.res = ^(id obj){
        NSString *userId = (NSString *)obj;
        if (weakSelf.resblock) {
            weakSelf.resblock(userId);
        }
    };
}

@end
