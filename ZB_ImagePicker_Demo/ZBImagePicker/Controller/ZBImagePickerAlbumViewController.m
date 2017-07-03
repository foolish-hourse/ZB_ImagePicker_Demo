//
//  ZBImagePickerAlbumViewController.m
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#import "ZBImagePickerAlbumViewController.h"
#import "ZBImagePickerViewController.h"

#import "ZBImagePickerConfig.h"

#import "ZBImagePickerAlbumCell.h"

#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

///按比例缩放尺寸
static CGSize CGSizeScale(CGSize size, CGFloat scale) {
    return CGSizeMake(size.width * scale, size.height * scale);
}

@interface ZBImagePickerAlbumViewController () <UITableViewDataSource, UITableViewDelegate, PHPhotoLibraryChangeObserver>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *albumArr;
@end

@implementation ZBImagePickerAlbumViewController
#pragma mark - lazy load
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

- (NSMutableArray *)albumArr {
    if (!_albumArr) {
        _albumArr = [NSMutableArray new];
    }
    return _albumArr;
}

#pragma mark - view Func
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navTitle = @"照片";
    // Register observer
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
    
    self.tableView.hidden = NO;
    [self loadData];
    
}

#pragma mark - nav methods
- (void)navButtonLeftClick:(UIButton *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.albumArr.count;;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZBImagePickerAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:@"albumCell"];
    if (!cell) {
        cell = [[ZBImagePickerAlbumCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"albumCell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.tag = indexPath.row;
    
    PHAssetCollection *assetCollection = self.albumArr[indexPath.row];
    PHFetchOptions *options = [PHFetchOptions new];
    
//    switch (self.imagePickerController.mediaType) {
//        case QBImagePickerMediaTypeImage:
            options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
//            break;
//            
//        case QBImagePickerMediaTypeVideo:
//            options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeVideo];
//            break;
//            
//        default:
//            break;
//    }
    
    PHFetchResult *fetchResult = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
    PHImageManager *imageManager = [PHImageManager defaultManager];
    
    if (fetchResult.count >= 3) {
        cell.albumThreeImageView.hidden = NO;
        
        [imageManager requestImageForAsset:fetchResult[fetchResult.count - 3]
                                targetSize:CGSizeScale(cell.albumThreeImageView.frame.size, [[UIScreen mainScreen] scale])
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 if (cell.tag == indexPath.row) {
                                     cell.albumThreeImageView.image = result;
                                 }
                             }];
    }else {
        cell.albumThreeImageView.hidden = YES;
    }
    
    if (fetchResult.count >= 2) {
        cell.albumTwoImageView.hidden = NO;
        
        [imageManager requestImageForAsset:fetchResult[fetchResult.count - 2]
                                targetSize:CGSizeScale(cell.albumTwoImageView.frame.size, [[UIScreen mainScreen] scale])
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 if (cell.tag == indexPath.row) {
                                     cell.albumTwoImageView.image = result;
                                 }
                             }];
    }else {
        cell.albumTwoImageView.hidden = YES;
    }
    
    if (fetchResult.count >= 1) {
        [imageManager requestImageForAsset:fetchResult[fetchResult.count - 1]
                                targetSize:CGSizeScale(cell.albumOneImageView.frame.size, [[UIScreen mainScreen] scale])
                               contentMode:PHImageContentModeAspectFill
                                   options:nil
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 if (cell.tag == indexPath.row) {
                                     cell.albumOneImageView.image = result;
                                 }
                             }];
    }
    
    if (fetchResult.count == 0) {
        cell.albumThreeImageView.hidden = NO;
        cell.albumTwoImageView.hidden = NO;
        
        UIImage *placeholderImage = [self placeholderImageWithSize:cell.albumOneImageView.frame.size];
        cell.albumOneImageView.image = placeholderImage;
        cell.albumThreeImageView.image = placeholderImage;
        cell.albumThreeImageView.image = placeholderImage;
    }
    cell.albumTitleLabel.text = assetCollection.localizedTitle;
    cell.albumNumLabel.text = [NSString stringWithFormat:@"%lu", (long)fetchResult.count];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.layoutMargins = UIEdgeInsetsZero;
    cell.preservesSuperviewLayoutMargins = NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ZB_adaptHeight(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"indexpath:%ld",(long)indexPath.row);
    ZBImagePickerViewController *vc = [[ZBImagePickerViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - PHPhotoLibraryChangeObserver
- (void)photoLibraryDidChange:(PHChange *)changeInstance {
    NSLog(@"photoLibraryDidChange");
}

#pragma mark - methods
///按尺寸size生成默认图片
- (UIImage *)placeholderImageWithSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *backgroundColor = [UIColor colorWithRed:(239.0 / 255.0) green:(239.0 / 255.0) blue:(244.0 / 255.0) alpha:1.0];
    UIColor *iconColor = [UIColor colorWithRed:(179.0 / 255.0) green:(179.0 / 255.0) blue:(182.0 / 255.0) alpha:1.0];
    
    // Background
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // Icon (back)
    CGRect backIconRect = CGRectMake(size.width * (16.0 / 68.0),
                                     size.height * (20.0 / 68.0),
                                     size.width * (32.0 / 68.0),
                                     size.height * (24.0 / 68.0));
    
    CGContextSetFillColorWithColor(context, [iconColor CGColor]);
    CGContextFillRect(context, backIconRect);
    
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, CGRectInset(backIconRect, 1.0, 1.0));
    
    // Icon (front)
    CGRect frontIconRect = CGRectMake(size.width * (20.0 / 68.0),
                                      size.height * (24.0 / 68.0),
                                      size.width * (32.0 / 68.0),
                                      size.height * (24.0 / 68.0));
    
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, CGRectInset(frontIconRect, -1.0, -1.0));
    
    CGContextSetFillColorWithColor(context, [iconColor CGColor]);
    CGContextFillRect(context, frontIconRect);
    
    CGContextSetFillColorWithColor(context, [backgroundColor CGColor]);
    CGContextFillRect(context, CGRectInset(frontIconRect, 1.0, 1.0));
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


#pragma mark - data methods
- (void)loadData {
    NSArray *assetCollectionSubtypes = @[
                                     @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                     @(PHAssetCollectionSubtypeAlbumMyPhotoStream),
                                     @(PHAssetCollectionSubtypeSmartAlbumPanoramas),
                                     @(PHAssetCollectionSubtypeSmartAlbumVideos),
                                     @(PHAssetCollectionSubtypeSmartAlbumBursts)
                                     ];
    
    // Fetch user albums and smart albums
    PHFetchResult *smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    PHFetchResult *userAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    NSArray *fetchResults = @[smartAlbums, userAlbums];

    // Filter albums
    NSMutableDictionary *smartsAlbums = [NSMutableDictionary dictionaryWithCapacity:assetCollectionSubtypes.count];
    NSMutableArray *usersAlbums = [NSMutableArray array];
    
    for (PHFetchResult *fetchResult in fetchResults) {
        [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection *assetCollection, NSUInteger index, BOOL *stop) {
            PHAssetCollectionSubtype subtype = assetCollection.assetCollectionSubtype;
            
            if (subtype == PHAssetCollectionSubtypeAlbumRegular) {
                [usersAlbums addObject:assetCollection];
            } else if ([assetCollectionSubtypes containsObject:@(subtype)]) {
                if (!smartsAlbums[@(subtype)]) {
                    smartsAlbums[@(subtype)] = [NSMutableArray array];
                }
                [smartsAlbums[@(subtype)] addObject:assetCollection];
            }
        }];
    }
    
    NSMutableArray *assetCollections = [NSMutableArray array];
    
    // Fetch smart albums
    for (NSNumber *assetCollectionSubtype in assetCollectionSubtypes) {
        NSArray *collections = smartsAlbums[assetCollectionSubtype];
        
        if (collections) {
            [assetCollections addObjectsFromArray:collections];
        }
    }
    
    // Fetch user albums
    [userAlbums enumerateObjectsUsingBlock:^(PHAssetCollection *assetCollection, NSUInteger index, BOOL *stop) {
        [assetCollections addObject:assetCollection];
    }];
    
    [self.albumArr removeAllObjects];
    [self.albumArr addObjectsFromArray:assetCollections];
    [self.tableView reloadData];
    
}

#pragma mark - dealloc
- (void)dealloc {
    [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}
@end
