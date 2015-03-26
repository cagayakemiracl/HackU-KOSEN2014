//
//  DrawPointInFace.m
//  FaceTracker
//
//  Created by 中原 啓雅 on 2015/03/26.
//  Copyright (c) 2015年 &#20013;&#21407;&#21843;&#38597;. All rights reserved.
//
#import "FaceTracker-Bridging-Header.h"

@implementation DrawPointInFace: NSObject
- (id)init:(int)sharp_at x:(double)x_move y:(double)y_move {
    self = [super init];

    self.sharp_at_ = sharp_at;
    self.x_move_ = x_move;
    self.y_move_ = y_move;

    return self;
}
@end

