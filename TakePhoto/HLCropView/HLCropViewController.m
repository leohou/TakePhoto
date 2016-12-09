//
//  HLCropViewController.m
//  TakePhoto
//
//  Created by houli on 16/12/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import "HLCropViewController.h"
#import "HLCropView.h"
@interface HLCropViewController ()
@property (nonatomic) HLCropView *cropView;
@property(nonatomic,strong) UIView * toolBarView;
@property(nonatomic,strong) UIButton *cancelButton;
@property(nonatomic,strong) UIButton *doneButton;
//@property (nonatomic) UIActionSheet *actionSheet;


@end

@implementation HLCropViewController

//获取bundle 国际化的东西
+ (NSBundle *)bundle
{

    static NSBundle *bundle = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
       
        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"PEPhotoCropEditor" withExtension:@"bundle"];
        bundle = [NSBundle bundleWithURL:bundleURL];
    });

    return bundle;
}

- (void)loadView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    contentView.backgroundColor = [UIColor blackColor];
    self.view = contentView;
    
    self.cropView = [[HLCropView alloc] initWithFrame:contentView.bounds];
    [contentView addSubview:self.cropView];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                          target:self
                                                                                          action:@selector(cancel:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                           target:self
                                                                                           action:@selector(done:)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                                   target:nil
                                                                                   action:nil];
//    UIBarButtonItem *constrainButton = [[UIBarButtonItem alloc] initWithTitle:PELocalizedString(@"Constrain", nil)
//                                                                        style:UIBarButtonItemStyleBordered
//                                                                       target:self
//                                                                       action:@selector(constrain:)];
    self.toolbarItems = @[flexibleSpace, flexibleSpace];
//    self.navigationController.navigationBarHidden = YES;
    self.cropView.image = self.image;
    
//    [self.view addSubview:self.toolBarView];
    
    [self.toolBarView addSubview:self.doneButton];
    [self.toolBarView addSubview:self.cancelButton];
    
}

-(void)viewDidAppear:(BOOL)animated
{

    [super viewDidAppear:animated];

}

-(UIView *)toolBarView
{
    if(!_toolBarView)
    {
        _toolBarView = [[UIView alloc]initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 100, [UIScreen mainScreen].bounds.size.width, 50)];
//        _toolBarView.backgroundColor = [UIColor redColor];
    }
    return _toolBarView;
}
-(UIButton *)doneButton
{
    if(!_doneButton)
    {
        _doneButton = [[UIButton alloc]initWithFrame:CGRectMake( [UIScreen mainScreen].bounds.size.width - 80,0,50, 50)];
        [_doneButton setTitle:@"选取" forState:UIControlStateNormal];
        [_doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _doneButton;
}

-(UIButton *)cancelButton
{
    if(!_cancelButton)
    {
        
        _cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(15, 0, 50, 50)];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    self.cropView.image = image;
}

- (void)cancel:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(cropViewControllerDidCancel:)]) {
        [self.delegate cropViewControllerDidCancel:self];
    }
}

- (void)done:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(cropViewController:didFinishCroppingImage:)]) {
        [self.delegate cropViewController:self didFinishCroppingImage:self.cropView.croppedImage];
    }
}

//- (void)constrain:(id)sender
//{
//    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil
//                                                   delegate:self
//                                          cancelButtonTitle:PELocalizedString(@"Cancel", nil)
//                                     destructiveButtonTitle:nil
//                                          otherButtonTitles:
//                        PELocalizedString(@"Original", nil),
//                        PELocalizedString(@"Square", nil),
//                        PELocalizedString(@"3 x 2", nil),
//                        PELocalizedString(@"3 x 5", nil),
//                        PELocalizedString(@"4 x 3", nil),
//                        PELocalizedString(@"4 x 6", nil),
//                        PELocalizedString(@"5 x 7", nil),
//                        PELocalizedString(@"8 x 10", nil),
//                        PELocalizedString(@"16 x 9", nil), nil];
//    [self.actionSheet showFromToolbar:self.navigationController.toolbar];
//}

////裁剪比例
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    if (buttonIndex == 0) {
//        CGRect cropRect = self.cropView.cropRect;
//        CGSize size = self.cropView.image.size;
//        CGFloat width = size.width;
//        CGFloat height = size.height;
//        CGFloat ratio;
//        if (width < height) {
//            ratio = width / height;
//            cropRect.size = CGSizeMake(CGRectGetHeight(cropRect) * ratio, CGRectGetHeight(cropRect));
//        } else {
//            ratio = height / width;
//            cropRect.size = CGSizeMake(CGRectGetWidth(cropRect), CGRectGetWidth(cropRect) * ratio);
//        }
//        self.cropView.cropRect = cropRect;
//    } else if (buttonIndex == 1) {
//        self.cropView.aspectRatio = 1.0f;
//    } else if (buttonIndex == 2) {
//        self.cropView.aspectRatio = 2.0f / 3.0f;
//    } else if (buttonIndex == 3) {
//        self.cropView.aspectRatio = 3.0f / 5.0f;
//    } else if (buttonIndex == 4) {
//        CGFloat ratio = 3.0f / 4.0f;
//        CGRect cropRect = self.cropView.cropRect;
//        CGFloat width = CGRectGetHeight(cropRect);
//        cropRect.size = CGSizeMake(width, width * ratio);
//        self.cropView.cropRect = cropRect;
//    } else if (buttonIndex == 5) {
//        self.cropView.aspectRatio = 4.0f / 6.0f;
//    } else if (buttonIndex == 6) {
//        self.cropView.aspectRatio = 5.0f / 7.0f;
//    } else if (buttonIndex == 7) {
//        self.cropView.aspectRatio = 8.0f / 10.0f;
//    } else if (buttonIndex == 8) {
//        CGFloat ratio = 9.0f / 16.0f;
//        CGRect cropRect = self.cropView.cropRect;
//        CGFloat width = CGRectGetHeight(cropRect);
//        cropRect.size = CGSizeMake(width, width * ratio);
//        self.cropView.cropRect = cropRect;
//    }
//}

@end
