//
//  DisLocationUpdateReq.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DisLocationUpdateReq.h"

@implementation DisLocationUpdateReq

- (YTKRequestMethod)requestMethod{
    return YTKRequestMethodPOST;
}

- (NSString *)requestUrl{
    return @"api/upload";
}

- (void)startRequest{
    [self startWithCompletionBlockWithSuccess:^(DisLocationUpdateReq *request){
        NSLog(@"上传成功");
    } failure:^(DisLocationUpdateReq *request){
        DLog(@"上传失败 %@",request.responseString);
    }];
}


@end
