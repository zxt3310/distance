//
//  FlexBaseWithoutNaviViewController.m
//  TYSalePlatForm
//
//  Created by zhangxintao on 2019/4/28.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "FlexBaseWithoutNaviViewController.h"

@interface FlexBaseWithoutNaviViewController ()

@end

@implementation FlexBaseWithoutNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}

- (UIEdgeInsets)getSafeArea:(BOOL)portrait{
    UIEdgeInsets inset = UIEdgeInsetsMake(kStatusBarHeight, 0, kTabBarHeight, 0);
    return inset;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
