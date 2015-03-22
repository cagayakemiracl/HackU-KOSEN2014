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
#include <future>

using namespace FACETRACKER;

static Tracker *model;
static cv::Mat con, tri;

@implementation Recognition: NSObject

- (id)init {
    self = [super init];

    auto ftPath  = [[NSBundle mainBundle] pathForResource:@"face2" ofType:@"tracker"];
    auto conPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"con"];
    auto triPath = [[NSBundle mainBundle] pathForResource:@"face" ofType:@"tri"];

    auto ftFile = [ftPath cStringUsingEncoding:[NSString defaultCStringEncoding]];
    auto conFile = [conPath cStringUsingEncoding:[NSString defaultCStringEncoding]];
    auto triFile = [triPath cStringUsingEncoding:[NSString defaultCStringEncoding]];

    model = new Tracker(ftFile);
    con = IO::LoadCon(conFile);
    tri = IO::LoadTri(triFile);

    return self;
}

- (UIImage *)Apply:(UIImage *)image {
    cv::Mat im;
    UIImageToMat(image, im, false);
    FaceTracker::ApplyFaceRecognition(im, *model, con, tri);
    
    return  MatToUIImage(im);
}

- (void)FrameReset {
    model->FrameReset();
}

- (NSArray *)GetPoints {
    auto points = [NSMutableArray array];
    auto n = model->_shape.rows / 2;
    for (auto i = 0; i < n; ++i) {
        auto point = CGPointMake(model->_shape.at<double>(i, 0),
                                 model->_shape.at<double>(i + n, 0));
        [points addObject: [NSValue valueWithCGPoint:point]];
    }

    return [points copy];
}

@end