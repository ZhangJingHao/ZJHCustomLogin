//
//  ViewController.m
//  ZJHCustomLogin
//
//  Created by ZhangJingHao on 16/6/30.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import "ViewController.h"
#import "CustomLoginView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 添加登录页面
    CGFloat loginH = 150;
    CGFloat loginY = self.view.frame.size.height - loginH;
    CustomLoginView *login = [[CustomLoginView alloc] initWithFrame:CGRectMake(0, loginY, self.view.frame.size.width, loginH)];
    login.vc = self;
    [self.view addSubview:login];
    
    // 获取三方数据
    login.customLoginBlock = ^(UMSocialAccountEntity *snsAccount){
        NSLog(@"\nusername = %@,\n usid = %@,\n token = %@ iconUrl = %@,\n unionId = %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL, snsAccount.unionId);
    };
}

@end
