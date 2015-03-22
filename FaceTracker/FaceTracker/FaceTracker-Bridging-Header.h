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

@interface Recognition: NSObject
- (id)init;
- (UIImage *)Apply:(UIImage *)image;
- (void)FrameReset;
- (NSArray *)GetPoints;
@end

@interface ImageController: NSObject
- (UIImage *)createImageFromBuffer:(CMSampleBufferRef) sbrBuffer;
@end
