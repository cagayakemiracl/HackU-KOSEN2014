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
static cv::Scalar color;

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
    color = CV_RGB(255, 0, 0);

    return self;
}

- (UIImage *)Apply:(UIImage *)image drawPoints:(NSArray *)array{
    cv::Mat im;
    UIImageToMat(image, im, false);
    FaceTracker::ApplyFaceRecognition(im, *model, con, tri);
    if (!array) return MatToUIImage(im);

    for (auto i = 0; i < array.count; ++i) {
        DrawPointInFace *drawPointInFace = [array objectAtIndex:i];
        auto pointAt = [self GetPointAt:drawPointInFace.sharp_at_];
        auto drawX = [[pointAt objectAtIndex:0] doubleValue] + drawPointInFace.x_move_;
        auto drawY = [[pointAt objectAtIndex:1] doubleValue] + drawPointInFace.y_move_;
        auto drawPoint = cv::Point(drawX, drawY);
        cv::circle(im, drawPoint, 5, color, CV_AA);
    }
    
    return  MatToUIImage(im);
}

- (void)FrameReset {
    model->FrameReset();
}

- (NSArray *)GetPoints {
    auto points = [NSMutableArray array];
    auto n = model->_shape.rows / 2;
    for (auto i = 0; i < n; ++i) {
        [points addObject: [NSNumber numberWithDouble:model->_shape.at<double>(i, 0)]];
        [points addObject: [NSNumber numberWithDouble:model->_shape.at<double>(i + n, 0)]];
    }

    return [points copy];
}

- (void)PrintPoints {
    auto points = [self GetPoints];
    for (auto i = 0; i < points.count; ++i) {
        NSLog(@"%@", [points objectAtIndex:i]);
    }
}

- (NSArray *)GetPointAt:(int)sharp_at {
    auto pointAt = [NSMutableArray array];
    auto n = model->_shape.rows / 2;
    [pointAt addObject: [NSNumber numberWithDouble:model->_shape.at<double>(sharp_at, 0)]];
    [pointAt addObject: [NSNumber numberWithDouble:model->_shape.at<double>(sharp_at + n, 0)]];

    return [pointAt copy];
}
@end