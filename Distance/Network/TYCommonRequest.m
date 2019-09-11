//
//  TYCommonRequest.m
//  TYSalePlatForm
//
//  Created by zhangxintao on 2019/6/26.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "TYCommonRequest.h"

@implementation TYCommonRequest
{
    id paramm;
}

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.delegate = self;
//    }
//    return self;
//}

- (instancetype) initWithParam:(id)param{
    self = [super init];
    if (self) {
        paramm = [param yy_modelToJSONObject];
        self.delegate = self;
    }
    return self;
}

- (id)requestArgument{
    return paramm;
}

//- (NSDictionary<NSString *,NSString *> *)requestHeaderFieldValueDictionary{
//    NSString *key = @"token";
//    NSHTTPCookie *cookie = [TYSaleCookieTool cookieWithName:key];
//
//    NSInteger time = [[NSDate date] timeIntervalSince1970];
//    NSString *str = [NSString stringWithFormat:@"%@fx%@",stringOfNumber(time+123),VERSION];
//
//    NSDictionary *header = [NSDictionary dictionaryWithObjectsAndKeys:PlatFormId,@"platformId",md5HexDigest(str),@"key",stringOfNumber(time),@"time",VERSION,@"version",cookie.value,@"Authorization",nil];
//    return header;
//}

- (void)requestFinished:(__kindof YTKBaseRequest *)request{
    
}

- (void)requestFailed:(__kindof YTKBaseRequest *)request{
//    NSNumber *result = [request.responseObject objectForKey:@"ret"];
//    if ([result integerValue] == TokenInvalid) {
//        if ([TYSaleCookieTool cookieWithName:@"token"]) {
//            [SVProgressHUD showInfoWithStatus:@"身份已失效，请重新登录"];
//        }
//
//        [UIApplication sharedApplication].keyWindow.rootViewController = [TYSaleStaticObj shareObj].UserLoginVC;
//    }
}

- (void)startRequest{
    
}

- (YTKResponseSerializerType)responseSerializerType{
    return YTKResponseSerializerTypeJSON;
}

- (id)jsonValidator{
    return @{
             @"err":[NSNumber class],
             @"data":[NSObject class]
             };
}

@end
