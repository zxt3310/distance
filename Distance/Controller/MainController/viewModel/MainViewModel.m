
//
//  MainViewModel.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "MainViewModel.h"
#import "DistanceListReqest.h"

@implementation MainViewModel

- (void)getDisList{
    DistanceListReqest *req = [[DistanceListReqest alloc] initWithParam:[DISUserInfo sharedInfo]];
    [req startRequest];
    
    __weak typeof(self) weakSelf = self;
    req.res = ^(id obj){
        NSArray *list = obj;
        if (weakSelf.NetRes) {
            weakSelf.NetRes(list);
        }
    };
}

@end
