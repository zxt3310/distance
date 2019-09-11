//
//  DistanceListReqest.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DistanceListReqest.h"
#import "DistanceModel.h"

@implementation DistanceListReqest

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl{
    return @"api/list";
}

- (void)startRequest{
    [self startWithCompletionBlockWithSuccess:^(DistanceListReqest *request){
        NSDictionary *dic = [request.responseObject objectForKey:@"data"];
        NSArray *list = [NSArray yy_modelArrayWithClass:[DistanceModel class] json:dic];
        if (self.res) {
            self.res(list);
        }
    } failure:^(DistanceListReqest *request){
        DLog(@"列表获取失败 %@",request.responseString);
    }];
}

@end
