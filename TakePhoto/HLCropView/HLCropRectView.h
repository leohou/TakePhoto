//
//  HLCropRectView.h
//  TakePhoto
//
//  Created by houli on 16/12/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLCropRectView : UIView
@property (nonatomic) id delegate;
@property (nonatomic) BOOL showsGridMajor;
@property (nonatomic) BOOL showsGridMinor;

@end

@protocol PECropRectViewDelegate <NSObject>

- (void)cropRectViewDidBeginEditing:(HLCropRectView *)cropRectView;
- (void)cropRectViewEditingChanged:(HLCropRectView *)cropRectView;
- (void)cropRectViewDidEndEditing:(HLCropRectView *)cropRectView;

@end
