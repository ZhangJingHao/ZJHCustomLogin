//
//  CustomLoginView.m
//  SanQu
//
//  Created by ZhangJingHao on 16/6/28.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import "CustomLoginView.h"
#import "CustomButton.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"

@implementation CustomLoginView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initOtherUI:frame];
    }
    return self;
}

- (void)initOtherUI:(CGRect)frame
{
    // 是否已安装微信
//    if (![WXApi isWXAppInstalled]) {
//        return;
//    }
    
    self.backgroundColor = [UIColor whiteColor];
    CGFloat width = frame.size.width;
    
    // 标题
    CGFloat titleW = MY_WIDTH(130);
    CGFloat titleH = MY_WIDTH(30);
    CGFloat titleX = (width - titleW) / 2;
    UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, titleW, titleH)];
    titleLab.text = @"第三方式登录";
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = FONT_SIZE(14);
    titleLab.textColor = [UIColor darkGrayColor];
    [self addSubview:titleLab];
    titleLab.backgroundColor = self.backgroundColor;
    
    // 横线
    CGFloat lineX = MY_WIDTH(15);
    CGFloat lineW = width - lineX * 2;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(lineX, titleH / 2, lineW, 0.5)];
    lineView.backgroundColor = RGB_ColorSame(222);
    [self insertSubview:lineView belowSubview:titleLab];
    
    // 按钮视图
    CGFloat iconX = MY_WIDTH(15);
    CGFloat iconW = width - iconX * 2;
    CGFloat iconY = titleH + MY_WIDTH(5);
    CGFloat iconH = MY_WIDTH(80);
    UIView *iconView = [[UIView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
    [self addSubview:iconView];
    
    // 按钮
    NSArray *nameArr = @[@"微信登录", @"QQ登录", @"微博登录"];
    NSArray *iconArr = @[@"share_wechat", @"share_qq", @"icon_invitation_weibo"];
    CGFloat btnW = MY_WIDTH(60);
    CGFloat btnX = 0;
    CGFloat distance = (iconW - btnW * 3) / 4;
    for (int i = 0; i < nameArr.count; i++) {
        btnX = distance + (distance + btnW) * i;
        CustomButton *btn = [[CustomButton alloc] initWithFrame:CGRectMake(btnX, 0, btnW, iconH)];
        btn.type = CustomButtonType_Login;
        btn.tag = i;
        [btn setImage:[UIImage imageNamed:iconArr[i]] forState:UIControlStateNormal];
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [iconView addSubview:btn];
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}

- (void)clickBtn:(UIButton *)btn
{
    // 平台
    NSString *sns = nil;
    
    if (btn.tag == 0) {         // 微信登录
        sns =  UMShareToWechatSession;
    } else if (btn.tag == 1) { // QQ登录
        sns =  UMShareToQQ;
    } else if (btn.tag == 2) { // 微博登录
        sns =  UMShareToSina;
    }
    
    // Sns平台类
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:sns];
    
    // 获取数据
    snsPlatform.loginClickHandler(_vc,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:snsPlatform.platformName];
            if (_customLoginBlock) {
                _customLoginBlock(snsAccount);
            }
        }});
}

@end









