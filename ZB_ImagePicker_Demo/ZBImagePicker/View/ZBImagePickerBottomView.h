//
//  ZBImagePickerBottomView.h
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZBImagePickerBottomView;
@protocol ZBImagePickerBottomViewDelegate <NSObject>
@optional
- (void)imagePickerBottomView:(ZBImagePickerBottomView *)bottomView finishButton:(UIButton *)finishButton;
@end

@interface ZBImagePickerBottomView : UIView
///底部完成按钮
@property (nonatomic, strong) UIButton *finishButton;

@property (nonatomic, weak) id<ZBImagePickerBottomViewDelegate> delegate;
@end
