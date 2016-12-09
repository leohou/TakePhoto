//
//  ViewController.m
//  TakePhoto
//
//  Created by houli on 16/12/8.
//  Copyright © 2016年 com. All rights reserved.
//

#import "ViewController.h"
#import "HLCropViewController.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,HLCropViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,strong) UIPopoverPresentationController *popover;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (IBAction)clickTakePhoto:(id)sender {
    
    
    UIAlertController *alertAction = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                                
    
    UIAlertAction * showCamera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self _showCamera];
        
    }];
    UIAlertAction * openPhoto = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        
        [self _openPhotoAlbum];
        
    }];

    UIAlertAction* fnish1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];

    [alertAction addAction:openPhoto];
    [alertAction addAction:showCamera];
    [alertAction addAction:fnish1];
    [self presentViewController:alertAction animated:YES completion:nil];
}

- (void)_openPhotoAlbum{

    
    UIImagePickerController * controller = [[UIImagePickerController alloc]init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
    }else{
    
        [self presentViewController:controller animated:YES completion:^{
            
        }];
    
    }
}

#pragma mark - uiimagePickerController
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    self.imageView.image = image;

    [picker dismissViewControllerAnimated:YES completion:^{
        
        [self _openEditor:nil];
    }];

}
//相机
- (void)_showCamera
{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    controller.delegate = self;
    controller.sourceType = UIImagePickerControllerSourceTypeCamera;
    
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        if (self.popover.isPopoverVisible) {
//            [self.popover dismissPopoverAnimated:NO];
//        }
//        
//        self.popover = [[UIPopoverController alloc] initWithContentViewController:controller];
//        [self.popover presentPopoverFromBarButtonItem:self.cameraButton
//                             permittedArrowDirections:UIPopoverArrowDirectionAny
//                                             animated:YES];
//    } else {
        [self presentViewController:controller animated:YES completion:NULL];
//    }
}

- (void)_openEditor:(UIImage *)image{
   
    HLCropViewController *controller = [[HLCropViewController alloc] init];
    controller.delegate = self;
    controller.image = self.imageView.image;
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    
    
    [self presentViewController:navigationController animated:YES completion:NULL];
    
}

#pragma mark - HLCropViewControllerDelegate

- (void)cropViewController:(HLCropViewController *)controller didFinishCroppingImage:(UIImage *)croppedImage
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
    self.imageView.image = croppedImage;
}

- (void)cropViewControllerDidCancel:(HLCropViewController *)controller
{
    [controller dismissViewControllerAnimated:YES completion:NULL];
}





@end
