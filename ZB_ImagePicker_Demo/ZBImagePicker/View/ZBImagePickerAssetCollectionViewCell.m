//
//  ZBImagePickerAssetCollectionViewCell.m
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/5.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import "ZBImagePickerAssetCollectionViewCell.h"

@implementation ZBImagePickerAssetCollectionViewCell
#pragma mark - init methods
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        UIImageView *assetImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self.contentView addSubview:assetImageView];
        _assetImageView = assetImageView;
//
//        UIImageView *albumTwoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZB_adaptWidth(12), ZB_adaptHeight(8), ZB_adaptHeight(80), ZB_adaptHeight(80))];
//        [self.contentView addSubview:albumTwoImageView];
//        _albumTwoImageView = albumTwoImageView;
//        
//        UIImageView *albumThreeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ZB_adaptWidth(14), ZB_adaptHeight(6), ZB_adaptHeight(80), ZB_adaptHeight(80))];
//        [self.contentView addSubview:albumThreeImageView];
//        _albumThreeImageView = albumThreeImageView;
//        
//        UILabel *albumTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(albumOneImageView.frame.origin.x + albumOneImageView.frame.size.width + ZB_adaptWidth(15), ZB_adaptHeight(20), ZB_adaptWidth(200), ZB_adaptHeight(18))];
//        [self.contentView addSubview:albumTitleLabel];
//        albumTitleLabel.textColor = [UIColor blackColor];
//        albumTitleLabel.font = [UIFont systemFontOfSize:ZB_adaptFont(15)];
//        albumTitleLabel.textAlignment = NSTextAlignmentLeft;
//        _albumTitleLabel = albumTitleLabel;
//        
//        UILabel *albumNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(albumOneImageView.frame.origin.x + albumOneImageView.frame.size.width + ZB_adaptWidth(15), albumTitleLabel.frame.origin.y + albumTitleLabel.frame.size.height + ZB_adaptHeight(5), ZB_adaptWidth(200), ZB_adaptHeight(14))];
//        [self.contentView addSubview:albumNumLabel];
//        albumNumLabel.textColor = [UIColor blackColor];
//        albumNumLabel.font = [UIFont systemFontOfSize:ZB_adaptFont(12)];
//        albumNumLabel.textAlignment = NSTextAlignmentLeft;
//        _albumNumLabel = albumNumLabel;
        
        
    }
    return self;
}
@end
