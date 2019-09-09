//
//  FlexBaseWithNaviViewController.m
//  TYSalePlatForm
//
//  Created by zhangxintao on 2019/4/28.
//  Copyright © 2019 zhangxintao. All rights reserved.
//

#import "FlexBaseWithNaviViewController.h"


@interface FlexBaseWithNaviViewController ()
{

}
@end

@implementation FlexBaseWithNaviViewController
@synthesize title = _title;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _bar = [[TYSPNaviBar alloc] initWithFlex:@"TYSPNaviBar"
                                       Frame:CGRectMake(0, 0, kScreenWidth, kNavBarAndStatusBarHeight)
                                       Owner:nil];
    [self.view addSubview:_bar];
    
    __weak typeof(self) weakSelf = self;
    _bar.shouldPop = ^{
        if ([weakSelf respondsToSelector:@selector(shouldChangePop)]) {
            [weakSelf performSelector:@selector(shouldChangePop)];
        }else{
            [weakSelf shouldPop];
        }
    };
    
    _bar.rightCall = ^{
        [weakSelf rightItemCall];
    };
}

- (void)shouldPop{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    [_bar setTitle:title];
}

- (void)rightItemCall{
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    //[super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (UIEdgeInsets)getSafeArea:(BOOL)portrait{
    UIEdgeInsets inset = UIEdgeInsetsMake(kNavBarAndStatusBarHeight, 0, kBottomSafeHeight, 0);
    return inset;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
