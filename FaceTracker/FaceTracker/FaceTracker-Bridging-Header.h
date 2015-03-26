//
//  Header.h
//  FaceTracker
//
//  Created by 中原 啓雅 on 2015/03/19.
//  Copyright (c) 2015年 &#20013;&#21407;&#21843;&#38597;. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface DrawPointInFace: NSObject
- (id)init:(int)sharp_at x:(double)x_move y:(double)y_move;
@property (nonatomic)int sharp_at_;
@property (nonatomic)double x_move_;
@property (nonatomic)double y_move_;
@end

@interface Recognition: NSObject
- (id)init;
- (UIImage *)Apply:(UIImage *)image drawPoints:(NSArray *)array;
- (void)FrameReset;
- (NSArray *)GetPoints;
- (void)PrintPoints;
- (NSArray *)GetPointAt:(int)sharp_at;
@end

@interface ImageController: NSObject
- (UIImage *)createImageFromBuffer:(CMSampleBufferRef) sbrBuffer;
@end
