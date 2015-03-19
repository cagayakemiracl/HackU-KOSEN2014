//
//  recognition.m
//  FaceTracker
//
//  Created by 中原 啓雅 on 2015/03/19.
//  Copyright (c) 2015年 &#20013;&#21407;&#21843;&#38597;. All rights reserved.
//

#import <FaceTracker-Bridging-Header.h>

#include <FaceTracker/FaceTracker.h>
#include <opencv2/opencv.hpp>
#include <opencv2/highgui/ios.h>
#include <iostream>

using namespace FACETRACKER;

static Tracker model;
static cv::Mat con, tri;

static cv::Mat UIImageToMat(UIImage *image) {
        // UIImage -> cv::Mat変換
    CGColorSpaceRef colorSpace = CGImageGetColorSpace(image.CGImage);
    CGFloat cols = image.size.width;
    CGFloat rows = image.size.height;

    cv::Mat mat(rows, cols, CV_8UC4);

    CGContextRef contextRef = CGBitmapContextCreate(mat.data,
                                                    cols,
                                                    rows,
                                                    8,
                                                    mat.step[0],
                                                    colorSpace,
                                                    kCGImageAlphaNoneSkipLast |
                                                    kCGBitmapByteOrderDefault);

    CGContextDrawImage(contextRef, CGRectMake(0, 0, cols, rows), image.CGImage);
    CGContextRelease(contextRef);

    return mat;
}

@implementation Recognition: NSObject

- (id)init {
    self = [super init];

    NSError *error;
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSArray *directory = [[NSFileManager defaultManager]
                          contentsOfDirectoryAtPath:resourcePath error:&error];
    for (NSString *str in directory)
    {
        NSLog(@"FileName:%@",str);
    }

    auto ftPath  = [[NSBundle mainBundle] pathForResource:@"face2" ofType:@"tracker"];
    auto conPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"con"];
    auto triPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"tri"];

    auto ftFile = [ftPath cStringUsingEncoding:[NSString defaultCStringEncoding]];
    auto conFile = [conPath cStringUsingEncoding:[NSString defaultCStringEncoding]];
    auto triFile = [triPath cStringUsingEncoding:[NSString defaultCStringEncoding]];

    Tracker model(ftFile);
    con = IO::LoadCon(conFile);
    tri = IO::LoadTri(triFile);

    return self;
}

- (UIImage *)Apply:(UIImage *)image {
    auto im = UIImageToMat(image);
    FaceTracker::ApplyFaceRecognition(im, model, con, tri);

    return  MatToUIImage(im);
}

@end

