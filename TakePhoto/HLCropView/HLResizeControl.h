//
//  HLResizeControl.h
//  TakePhoto
//
//  Created by houli on 16/12/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HLResizeControl : UIView
@property (weak, nonatomic) id delegate;
@property (nonatomic, readonly) CGPoint translation;


@end
@protocol PEResizeConrolViewDelegate <NSObject>

- (void)resizeConrolViewDidBeginResizing:(HLResizeControl *)resizeConrolView;
- (void)resizeConrolViewDidResize:(HLResizeControl *)resizeConrolView;
- (void)resizeConrolViewDidEndResizing:(HLResizeControl *)resizeConrolView;

@end
