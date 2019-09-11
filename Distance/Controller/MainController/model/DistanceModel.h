//
//  DistanceModel.h
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DistanceModel : NSObject
@property NSInteger user_id;
@property NSString *nick_name;
@property CGFloat distance;
@property NSString *updated_at;
@end

NS_ASSUME_NONNULL_END
