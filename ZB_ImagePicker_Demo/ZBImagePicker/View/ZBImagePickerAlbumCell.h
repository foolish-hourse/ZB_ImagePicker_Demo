//
//  ZBImagePickerAlbumCell.h
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZBImagePickerAlbumCell : UITableViewCell
///图片一视图
@property (nonatomic, strong) UIImageView *albumOneImageView;
///图片二视图
@property (nonatomic, strong) UIImageView *albumTwoImageView;
///图片三视图
@property (nonatomic, strong) UIImageView *albumThreeImageView;
///相册标题标签
@property (nonatomic, strong) UILabel *albumTitleLabel;
///相册数量标签
@property (nonatomic, strong) UILabel *albumNumLabel;
@end
