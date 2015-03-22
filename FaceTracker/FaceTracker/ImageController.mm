//
//  ImageController.m
//  FaceTracker
//
//  Created by 中原 啓雅 on 2015/03/22.
//  Copyright (c) 2015年 &#20013;&#21407;&#21843;&#38597;. All rights reserved.
//

#import "FaceTracker-Bridging-Header.h"
#import <opencv2/opencv.hpp>

@interface ImageController()
@property (nonatomic)CGColorSpaceRef CGColorSpace;
@end
@implementation ImageController

- (UIImage *) createImageFromBuffer:(CMSampleBufferRef) sbrBuffer
{
    auto imageBuffer = CMSampleBufferGetImageBuffer(sbrBuffer);

        // ピクセルバッファのベースアドレスをロックする
    CVPixelBufferLockBaseAddress(imageBuffer, 0);

        // Get information of the image
    auto baseAddress = (uint8_t *)CVPixelBufferGetBaseAddressOfPlane(imageBuffer, 0);

    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);

        // RGBの色空間
    self.CGColorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef newContext = CGBitmapContextCreate(baseAddress,
                                                    width,
                                                    height,
                                                    8,
                                                    bytesPerRow,
                                                    self.CGColorSpace,
                                                    kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedFirst);

    CGImageRef cgImage = CGBitmapContextCreateImage(newContext);

    CGContextRelease(newContext);
        //CGColorSpaceRelease(self.CGColorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);

    UIImage *image = [UIImage imageWithCGImage:cgImage];

    CGImageRelease(cgImage);

    return image;
}
@end