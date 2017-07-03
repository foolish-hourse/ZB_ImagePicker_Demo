//
//  ZBImagePickerViewController.m
//  MutImagePicker_Demo
//
//  Created by Martell on 17/7/2.
//  Copyright © 2017年 martell. All rights reserved.
//

#import "ZBImagePickerViewController.h"

@interface ZBImagePickerViewController ()
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation ZBImagePickerViewController
//#pragma mark - lazy load
//- (UICollectionView *)collectionView {
//    if (!_collectionView) {
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
//        [self.view addSubview:_collectionView];
//        _collectionView.dataSource = self;
//        _collectionView.delegate = self;
//    }
//    return _collectionView;
//}

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"相册";
}

@end
