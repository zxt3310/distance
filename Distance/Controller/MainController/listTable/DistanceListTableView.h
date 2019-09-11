//
//  DistanceListTableView.h
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>

@interface DistanceListTableView : FlexCustomBaseView
@property UITableView *listTable;
- (void)reload;
@property NSArray *distanceList;
@end


