//
//  DistanceListTableView.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "DistanceListTableView.h"
#import "DistanceTableCell.h"
#import "PRMovePathViewController.h"

@interface DistanceListTableView() <UITableViewDelegate,UITableViewDataSource>

@end

@implementation DistanceListTableView
{
    
}

- (void)onInit{
    [self enableFlexLayout:YES];
    
    _listTable.delegate = self;
    _listTable.dataSource = self;
    _listTable.rowHeight = UITableViewAutomaticDimension;
    _listTable.tableFooterView = [UIView new];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DistanceTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[DistanceTableCell alloc] initWithFlex:nil reuseIdentifier:@"cell"];
    }
    cell.distance = self.distanceList[indexPath.item];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.distanceList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PRMovePathViewController *vc = [[PRMovePathViewController alloc] init];
    [topViewController().navigationController pushViewController:vc animated:YES];
}

- (void)reload{
    [_listTable reloadData];
}

@end
