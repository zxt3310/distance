//
//  FlexBaseWithNaviViewController.h
//  TYSalePlatForm
//
//  Created by zhangxintao on 2019/4/28.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "FlexBaseVC.h"
#import "TYSPNaviBar.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^rightItemCallBack)(void);

@interface FlexBaseWithNaviViewController : FlexBaseVC
//@property rightItemCallBack rightCall;
@property TYSPNaviBar *bar;
//右侧点击动作
- (void)rightItemCall;
//左侧动作
- (void)shouldPop;
@end

NS_ASSUME_NONNULL_END
