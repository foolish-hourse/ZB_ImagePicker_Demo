//
//  ZBImagePickerViewController.m
//  MutImagePicker_Demo
//
//  Created by Martell on 17/7/2.
//  Copyright © 2017年 martell. All rights reserved.
//

#import "ZBImagePickerViewController.h"

#import "ZBImagePickerCollectionViewFlowLayout.h"

#import "ZBImagePickerConfig.h"

#import "ZBImagePickerBottomView.h"

#import "ZBImagePickerDataSourceModel.h"

///一行5个
#define ROWITEMCOUNT 5
///间距 10
#define MARGIN 2

@interface ZBImagePickerViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ZBImagePickerBottomViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZBImagePickerBottomView *bottomView;

@end

@implementation ZBImagePickerViewController
#pragma mark - lazy load
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        ZBImagePickerCollectionViewFlowLayout *flowlayout = [[ZBImagePickerCollectionViewFlowLayout alloc] init];
        flowlayout.minimumInteritemSpacing = 0;
        flowlayout.minimumLineSpacing = MARGIN;
        CGFloat itemWidth = ((self.view.frame.size.width - MARGIN * 2) - (ROWITEMCOUNT - 1) * MARGIN) / ROWITEMCOUNT;
        flowlayout.itemSize = CGSizeMake(itemWidth, itemWidth);
        flowlayout.sectionInset = UIEdgeInsetsMake(MARGIN, MARGIN, MARGIN, MARGIN);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49 - 64) collectionViewLayout:flowlayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self.view addSubview:_collectionView];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
    }
    return _collectionView;
}

- (ZBImagePickerBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ZBImagePickerBottomView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 49 - 64, self.view.frame.size.width, 49)];
        [self.view addSubview:_bottomView];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"相册";
    self.collectionView.hidden = NO;
    self.bottomView.hidden = NO;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 80;
}

// collectionHeaderView cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.item % 2) {
        cell.backgroundColor = [UIColor greenColor];
    }else {
        cell.backgroundColor = [UIColor yellowColor];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - ZBImagePickerBottomViewDelegate
- (void)imagePickerBottomView:(ZBImagePickerBottomView *)bottomView finishButton:(UIButton *)finishButton {
    
}

#pragma mark - set methods

@end
