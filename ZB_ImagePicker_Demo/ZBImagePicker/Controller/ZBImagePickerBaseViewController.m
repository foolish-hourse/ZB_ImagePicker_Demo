//
//  ZBImagePickerBaseViewController.m
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import "ZBImagePickerBaseViewController.h"

@interface ZBImagePickerBaseViewController ()

@end

@implementation ZBImagePickerBaseViewController

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    // 设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航栏
    [self initNavView];
}

#pragma mark - methods
- (void)initNavView {
    // 导航栏左侧按钮
    _navButtonLeft = [UIButton buttonWithType:UIButtonTypeCustom];
    _navButtonLeft.frame = CGRectMake(0, 0, 20, 20);
    [_navButtonLeft setImage:[UIImage imageNamed:@"nav_left_black"] forState:UIControlStateNormal];
    _navButtonLeft.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_navButtonLeft addTarget:self action:@selector(navButtonLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navButtonLeft];
    
    // 导航栏右侧按钮
    _navButtonRight = [UIButton buttonWithType:UIButtonTypeCustom];
    _navButtonRight.frame = CGRectMake(0, 0, 40 + 20, 40);
    _navButtonRight.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [_navButtonRight setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _navButtonRight.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [_navButtonRight addTarget:self action:@selector(navButtonRightClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_navButtonRight];
    
    // 导航栏背景色
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    // 设置导航栏字体颜色
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor], NSFontAttributeName : [UIFont boldSystemFontOfSize:18]};
}

#pragma mark - 按钮点击事件
///导航左按钮事件（默认返回上一页）
- (void)navButtonLeftClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

///导航右按钮事件（默认无内容）
- (void)navButtonRightClick:(UIButton *)sender {
    NSLog(@"navButtonRightClick");
}

#pragma mark - set method
- (void)setNavTitle:(NSString *)navTitle {
    _navTitle = navTitle;
    self.navigationItem.title = _navTitle;
}

@end
