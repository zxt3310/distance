//
//  DisLoginController.m
//  Distance
//
//  Created by 张信涛 on 2019/9/9.
//  Copyright © 2019年 张信涛. All rights reserved.
//

#import "DisLoginController.h"
#import "LoginViewModel.h"

@implementation DisLoginController
{
    UITextField *_userNameTF;
    LoginViewModel *viewModel;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        viewModel = [[LoginViewModel alloc] init];
    }
    return self;
}

- (void)viewDidLoad{
    
}

- (void)startLogin{
    if (KIsBlankString(_userNameTF.text)) {
        [SVProgressHUD showInfoWithStatus:@"缺少用户名"];
        return;
    }
    
    [DISUserInfo sharedInfo].username = _userNameTF.text;
    
    [viewModel starLogin];
    viewModel.resblock = ^(NSString *userId){
        [DISUserInfo sharedInfo].userid = userId;
        [[DISUserInfo sharedInfo] save];
        
        [[UIApplication sharedApplication].keyWindow setRootViewController:[DISStaticObj sharedObj].mainVC];
    };
}

@end
