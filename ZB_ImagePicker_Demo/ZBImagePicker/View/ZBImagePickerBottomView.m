//
//  ZBImagePickerBottomView.m
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import "ZBImagePickerBottomView.h"

@implementation ZBImagePickerBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:239 / 255.0 green:239 / 255.0 blue:240 / 255.0 alpha:1];
        UIButton *finishButton = [[UIButton alloc] initWithFrame:CGRectMake(frame.size.width - 15 - 100, (frame.size.height - 35) / 2, 100, 35)];
        [self addSubview:finishButton];
        finishButton.layer.masksToBounds = YES;
        finishButton.layer.cornerRadius = 5;
        finishButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [finishButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [finishButton setTitle:@"完成(0)" forState:UIControlStateNormal];
        finishButton.backgroundColor = [UIColor orangeColor];
        [finishButton addTarget:self action:@selector(finishButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _finishButton = finishButton;
    }
    return self;
}

#pragma mark - SEL
- (void)finishButtonClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(imagePickerBottomView:finishButton:)]) {
        [self.delegate imagePickerBottomView:self finishButton:sender];
    }
}

@end
