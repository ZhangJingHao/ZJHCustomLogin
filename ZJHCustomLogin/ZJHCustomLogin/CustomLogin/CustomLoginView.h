//
//  CustomLoginView.h
//  SanQu
//
//  Created by ZhangJingHao on 16/6/28.
//  Copyright © 2016年 ZhangJingHao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"

/**
 *  自定义三方登录
 */

@interface CustomLoginView : UIView

// 所在控制器
@property (nonatomic ,strong) UIViewController *vc;

// 获取数据回调
@property (nonatomic, copy) void (^customLoginBlock)(UMSocialAccountEntity *snsAccount);

@end
