//
//  ZBImagePickerBaseViewController.h
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBImagePickerBaseViewController : UIViewController
/// 导航栏左侧按钮（默认返回）
@property (nonatomic, strong) UIButton *navButtonLeft;
/// 导航栏右侧按钮（默认没有）
@property (nonatomic, strong) UIButton *navButtonRight;
/// 导航栏标题（默认无内容）
@property (nonatomic, copy)   NSString *navTitle;

/// 导航左按钮事件（默认导航栏pop）
- (void)navButtonLeftClick:(UIButton *)sender;
/// 导航右按钮事件（默认无内容）
- (void)navButtonRightClick:(UIButton *)sender;
@end
