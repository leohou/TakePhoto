//
//  HLCropView.h
//  TakePhoto
//
//  Created by houli on 16/12/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVFoundation.h>

@interface HLCropView : UIView
@property(nonatomic,strong) UIImage *image;
@property(nonatomic,readonly) UIImage *croppedImage;
@property (nonatomic) CGFloat aspectRatio;
@property (nonatomic) CGRect cropRect;

@end
