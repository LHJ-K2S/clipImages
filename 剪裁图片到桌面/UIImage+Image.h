//
//  UIImage+Image.h
//  生日管家
//
//  Created by yz on 15/7/6.
//  Copyright (c) 2015年 yz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Image)


// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;
// 拉伸图片
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;
// 返回一张未渲染的图片
+ (instancetype)imageWithRenderingModeOriginal:(NSString *)imageName;
// 对图片压缩
+ (UIImage *)imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
// 对图片压缩2
+ (UIImage *)resizeImage:(UIImage *)image toWidth:(CGFloat)width height:(CGFloat)height;
// 把图片按比例压缩
+ (instancetype)zoomImage:(UIImage *)image toScale:(CGFloat)scale;

@end
