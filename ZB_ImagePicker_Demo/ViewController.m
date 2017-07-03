//
//  ViewController.m
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import "ViewController.h"
#import "ZBImagePickerViewController.h"
#import "ZBNavigationViewController.h"

@interface ViewController ()

@end

@implementation ViewController

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 100 / 2, self.view.frame.size.height / 2 - 100 / 2, 100, 100)];
    [self.view addSubview:button];
    button.backgroundColor = [UIColor grayColor];
    [button setTitle:@"点击我" forState:UIControlStateNormal];
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 100 / 2;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - SEL
- (void)buttonClick:(UIButton *)sender {
    ZBNavigationViewController *nav = [[ZBNavigationViewController alloc] initWithRootViewController:[[ZBImagePickerViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}


@end
