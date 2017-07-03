//
//  ZBImagePickerConfig.h
//  ZB_ImagePicker_Demo
//
//  Created by CZB on 2017/7/3.
//  Copyright © 2017年 CZB. All rights reserved.
//

#ifndef ZBImagePickerConfig_h
#define ZBImagePickerConfig_h

///项目中使用到的宏
 
#define ZB_SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define ZB_SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
// 自适应设备宽度
#define ZB_adaptWidth(w) (ZB_SCREEN_WIDTH / 375 * (w))
// 自适应设备高度
#define ZB_adaptHeight(h) (ZB_SCREEN_HEIGHT / 667 * (h))
// 字体大小自适应
#define ZB_adaptFont(font) ((ZB_SCREEN_WIDTH / 375 * (font) < 12.0f && font >= 12.0f) ? 12.0f : ZB_SCREEN_WIDTH / 375 * (font))


#endif /* ZBImagePickerConfig_h */
