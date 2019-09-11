//
//  DISUserInfo.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DISUserInfo.h"

@implementation DISUserInfo

static DISUserInfo *info = nil;

+ (instancetype)sharedInfo{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [self loadStorage];
    });
    return info;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    return [self yy_modelInitWithCoder:aDecoder];
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    [self yy_modelEncodeWithCoder:aCoder];
}

+ (BOOL)supportsSecureCoding{
    return YES;
}

- (void)save{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self requiringSecureCoding:YES error:nil];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:LocalUser];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (id)loadStorage{
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:LocalUser];
    if (!data) {
        return [[self alloc] init];
    }
    else{
        return [NSKeyedUnarchiver unarchivedObjectOfClass:[self class] fromData:data error:nil];
    }
}

@end
