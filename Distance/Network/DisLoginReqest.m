//
//  DisLoginReqest.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DisLoginReqest.h"

@implementation DisLoginReqest

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl{
    return @"api/login";
}

- (void)startRequest{
    [self startWithCompletionBlockWithSuccess:^(DisLoginReqest *request){
        NSDictionary *dic = [request.responseObject objectForKey:@"data"];
        NSString *user_id = [dic objectForKey:@"user_id"];
        if (self.res) {
            self.res(user_id);
        }
    } failure:^(DisLoginReqest *request){
        DLog(@"登录失败 %@",request.responseString);
    }];
}

@end
