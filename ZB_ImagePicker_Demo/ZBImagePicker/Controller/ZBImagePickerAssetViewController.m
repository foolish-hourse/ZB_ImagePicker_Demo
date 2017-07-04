//
//  ZBImagePickerAssetViewController.m
//  MutImagePicker_Demo
//
//  Created by Martell on 17/7/2.
//  Copyright © 2017年 martell. All rights reserved.
//

#import "ZBImagePickerAssetViewController.h"

#import "ZBImagePickerCollectionViewFlowLayout.h"

#import "ZBImagePickerConfig.h"

#import "ZBImagePickerBottomView.h"
#import "ZBImagePickerAssetCollectionViewCell.h"

#import "ZBImagePickerDataSourceModel.h"

///一行4个
#define ROWITEMCOUNT 4
///间距 10
#define MARGIN 2

static CGSize CGSizeScale(CGSize size, CGFloat scale) {
    return CGSizeMake(size.width * scale, size.height * scale);
}

@interface ZBImagePickerAssetViewController () <UICollectionViewDataSource, UICollectionViewDelegate, ZBImagePickerBottomViewDelegate, PHPhotoLibraryChangeObserver>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ZBImagePickerBottomView *bottomView;

@property (nonatomic, strong) PHFetchResult *fetchResult;
@property (nonatomic, strong) PHCachingImageManager *imageManager;

@end

@implementation ZBImagePickerAssetViewController
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
        [_collectionView registerClass:[ZBImagePickerAssetCollectionViewCell class] forCellWithReuseIdentifier:@"assetCell"];
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

- (PHCachingImageManager *)imageManager {
    if (!_imageManager) {
        _imageManager = [PHCachingImageManager new];
    }
    
    return _imageManager;
}

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navTitle = @"相册";
    
    // Register observer
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
    self.collectionView.hidden = NO;
    self.bottomView.hidden = NO;
    
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fetchResult.count;
}

// collectionHeaderView cell样式
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZBImagePickerAssetCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"assetCell" forIndexPath:indexPath];
    cell.tag = indexPath.item;
//    cell.assetImageView.image = [UIImage imageNamed:@"nav_left_black"];
//    if (indexPath.item % 2) {
//        cell.backgroundColor = [UIColor greenColor];
//    }else {
//        cell.backgroundColor = [UIColor yellowColor];
//    }
    // Image
    PHAsset *asset = self.fetchResult[indexPath.item];
    CGSize itemSize = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize];
    CGSize targetSize = CGSizeScale(itemSize, [[UIScreen mainScreen] scale]);
    
    [self.imageManager requestImageForAsset:asset
                                 targetSize:targetSize
                                contentMode:PHImageContentModeAspectFill
                                    options:nil
                              resultHandler:^(UIImage *result, NSDictionary *info) {
                                  if (cell.tag == indexPath.item) {
                                      cell.assetImageView.image = result;
                                  }
                              }];
    
//    // Video indicator
//    if (asset.mediaType == PHAssetMediaTypeVideo) {
//        cell.videoIndicatorView.hidden = NO;
//        
//        NSInteger minutes = (NSInteger)(asset.duration / 60.0);
//        NSInteger seconds = (NSInteger)ceil(asset.duration - 60.0 * (double)minutes);
//        cell.videoIndicatorView.timeLabel.text = [NSString stringWithFormat:@"%02ld:%02ld", (long)minutes, (long)seconds];
//        
//        if (asset.mediaSubtypes & PHAssetMediaSubtypeVideoHighFrameRate) {
//            cell.videoIndicatorView.videoIcon.hidden = YES;
//            cell.videoIndicatorView.slomoIcon.hidden = NO;
//        }
//        else {
//            cell.videoIndicatorView.videoIcon.hidden = NO;
//            cell.videoIndicatorView.slomoIcon.hidden = YES;
//        }
//    } else {
//        cell.videoIndicatorView.hidden = YES;
//    }
    
//    // Selection state
//    if ([self.imagePickerController.selectedAssets containsObject:asset]) {
//        [cell setSelected:YES];
//        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
//    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - ZBImagePickerBottomViewDelegate
- (void)imagePickerBottomView:(ZBImagePickerBottomView *)bottomView finishButton:(UIButton *)finishButton {
    
}

#pragma mark - PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:self.fetchResult];
//        
//        if (collectionChanges) {
//            // Get the new fetch result
//            self.fetchResult = [collectionChanges fetchResultAfterChanges];
//            
//            if (![collectionChanges hasIncrementalChanges] || [collectionChanges hasMoves]) {
//                // We need to reload all if the incremental diffs are not available
//                [self.collectionView reloadData];
//            } else {
//                // If we have incremental diffs, tell the collection view to animate insertions and deletions
//                [self.collectionView performBatchUpdates:^{
//                    NSIndexSet *removedIndexes = [collectionChanges removedIndexes];
//                    if ([removedIndexes count]) {
//                        [self.collectionView deleteItemsAtIndexPaths:[removedIndexes qb_indexPathsFromIndexesWithSection:0]];
//                    }
//                    
//                    NSIndexSet *insertedIndexes = [collectionChanges insertedIndexes];
//                    if ([insertedIndexes count]) {
//                        [self.collectionView insertItemsAtIndexPaths:[insertedIndexes qb_indexPathsFromIndexesWithSection:0]];
//                    }
//                    
//                    NSIndexSet *changedIndexes = [collectionChanges changedIndexes];
//                    if ([changedIndexes count]) {
//                        [self.collectionView reloadItemsAtIndexPaths:[changedIndexes qb_indexPathsFromIndexesWithSection:0]];
//                    }
//                } completion:NULL];
//            }
//            
//            [self resetCachedAssets];
//        }
//    });
}

#pragma mark - methods
///更新fetch
- (void)updateFetchRequest {
//    if (self.assetCollection) {
        PHFetchOptions *options = [PHFetchOptions new];
        
//        switch (self.imagePickerController.mediaType) {
//            case QBImagePickerMediaTypeImage:
                options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
//                break;
//                
//            case QBImagePickerMediaTypeVideo:
//                options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeVideo];
//                break;
//
//            default:
//                break;
//        }
        
        self.fetchResult = [PHAsset fetchAssetsInAssetCollection:self.assetCollection options:options];
        
//        if ([self isAutoDeselectEnabled] && self.imagePickerController.selectedAssets.count > 0) {
            // Get index of previous selected asset
//            PHAsset *asset = [self.imagePickerController.selectedAssets firstObject];
//            NSInteger assetIndex = [self.fetchResult indexOfObject:asset];
//            self.lastSelectedItemIndexPath = [NSIndexPath indexPathForItem:assetIndex inSection:0];
//        }
//    } else {
//        self.fetchResult = nil;
//    }
}

#pragma mark - set methods
- (void)setAssetCollection:(PHAssetCollection *)assetCollection {
    _assetCollection = assetCollection;
    
    self.navTitle = assetCollection.localizedTitle;
    [self updateFetchRequest];
    [self.collectionView reloadData];
}
@end
