//
//  HLCropViewController.h
//  TakePhoto
//
//  Created by houli on 16/12/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HLCropViewController : UIViewController

@property(nonatomic) id delegate;
@property(nonatomic) UIImage *image;


@end
//由于需要传图片 所以考虑使用代理的方式
@protocol HLCropViewControllerDelegate <NSObject>

- (void)cropViewController:(HLCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage;
- (void)cropViewControllerDidCancel:(HLCropViewController *)controller;


@end

