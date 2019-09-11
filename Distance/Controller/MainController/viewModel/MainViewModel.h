//
//  MainViewModel.h
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^getListRes)(NSArray *list);

@interface MainViewModel : NSObject

@property getListRes NetRes;

- (void)getDisList;

@end

NS_ASSUME_NONNULL_END
