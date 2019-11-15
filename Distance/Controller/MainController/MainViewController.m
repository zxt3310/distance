//
//  MainViewController.m
//  Distance
//
//  Created by zhangxintao on 2019/9/10.
//  Copyright © 2019 张信涛. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "DistanceListTableView.h"
#import "DisLocationManager.h"

@implementation MainViewController
{
    MainViewModel *viewModel;
    DistanceListTableView *_listTable;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        viewModel = [[MainViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [[DisLocationManager sharedManager] addObserver:self forKeyPath:@"upDate" options:NSKeyValueObservingOptionNew context:@"fresh"];
    
    //__weak typeof(self) weakSelf = self;
    [_listTable.listTable addHeaderWithHeaderWithBeginRefresh:NO animation:YES refreshBlock:^(NSInteger page){
        [[DisLocationManager sharedManager] startLocation];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getList];
}

- (void)getList{
    
    [viewModel getDisList];
    __weak DistanceListTableView *weakTable = _listTable;
    viewModel.NetRes = ^(NSArray *list){
        weakTable.distanceList = list;
        [weakTable reload];
    };
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == @"fresh") {
        [self getList];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
