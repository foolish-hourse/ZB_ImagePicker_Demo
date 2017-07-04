//
//  ZBImagePickerAssetViewController.h
//  MutImagePicker_Demo
//
//  Created by Martell on 17/7/2.
//  Copyright © 2017年 martell. All rights reserved.
//

#import "ZBImagePickerBaseViewController.h"

#import <Photos/Photos.h>

@interface ZBImagePickerAssetViewController : ZBImagePickerBaseViewController
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@end
