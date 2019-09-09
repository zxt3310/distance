//
//  FlexBasePresentViewController.m
//  TYSalePlatForm
//
//  Created by zhangxintao on 2019/5/10.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "FlexBasePresentViewController.h"

@implementation FlexBasePresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UIEdgeInsets)getSafeArea:(BOOL)portrait{
    UIEdgeInsets inset = UIEdgeInsetsMake(kStatusBarHeight, 0, kBottomSafeHeight, 0);
    return inset;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
