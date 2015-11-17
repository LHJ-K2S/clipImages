//
//  ViewController.m
//  剪裁图片到桌面
//
//  Created by lhj on 11/13/15.
//  Copyright © 2015 lhj. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Image.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *widthTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;
@property (weak, nonatomic) IBOutlet UITextField *scaleTextField;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (nonatomic, strong) NSString *imagePath;

@end

@implementation ViewController

static NSString * const userName = @"lhj";



// 改进：优化写入图片的方法，防止出错，类似于保存图片到相册
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imagePath = [NSString stringWithFormat:@"/Users/%@/Desktop/123图片裁剪",userName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSError *error;
    if (![manager fileExistsAtPath:self.imagePath]) {
        [manager createDirectoryAtPath:self.imagePath withIntermediateDirectories:NO attributes:nil error:&error];
    }
    if (error) {
        self.infoLabel.text = @"请先打开ViewController，把里面的userName改成你电脑的用户名（电脑屏幕右上角那个就是）。改完之后请重新运行本程序。";
        self.view.userInteractionEnabled = NO;
    }else{
        self.infoLabel.text = @"已经在您桌面创建名为“123图片裁剪”的文件夹。请把要裁剪的图片放入这个文件夹，点击按钮之后就会在这个文件夹里生成对应的图片";
    }
}

- (IBAction)clipToItem:(id)sender {
    [self clipImageToWidth:25 height:25 scale:2 extraName:@"Item@2x" fileName:@"Item"];
    [self clipImageToWidth:25 height:25 scale:3 extraName:@"Item@3x" fileName:@"Item"];
}


- (IBAction)clipToAppIcon:(id)sender {
    [self clipImageToWidth:60 height:60 scale:2 extraName:@"APP@2x" fileName:@"APP"];
    [self clipImageToWidth:60 height:60 scale:3 extraName:@"APP@3x" fileName:@"APP"];
}



- (IBAction)clipToScale:(id)sender {
    CGFloat scale = self.scaleTextField.text.floatValue;
    if (scale) {
        [self clipImageToWidth:0 height:0 scale:scale extraName:nil fileName:@"指定比例缩放"];
    }else{
        NSLog(@"hehe");
    }
}

- (IBAction)clipToGiven:(id)sender {
    CGFloat width = self.widthTextField.text.floatValue;
    CGFloat height = self.heightTextField.text.floatValue;
    if (width && height) {
        [self clipImageToWidth:width height:height scale:1 extraName:nil fileName:@"指定尺寸"];
    }else{
        NSLog(@"hehe");
    }
}

- (IBAction)iPadAll:(id)sender {
    [self clipImageToWidth:29 height:29 scale:1 extraName:@"Setting" fileName:@"平板全家桶"];
    [self clipImageToWidth:29 height:29 scale:2 extraName:@"Setting@2x" fileName:@"平板全家桶"];
    [self clipImageToWidth:40 height:40 scale:1 extraName:@"Spotlight" fileName:@"平板全家桶"];
    [self clipImageToWidth:40 height:40 scale:2 extraName:@"Spotlight@2x" fileName:@"平板全家桶"];
    [self clipImageToWidth:76 height:76 scale:1 extraName:@"APP" fileName:@"平板全家桶"];
    [self clipImageToWidth:76 height:76 scale:2 extraName:@"APP@2x" fileName:@"平板全家桶"];
}
- (IBAction)iPhoneAll:(id)sender {
    [self clipImageToWidth:29 height:29 scale:2 extraName:@"Setting@2x" fileName:@"手机全家桶"];
    [self clipImageToWidth:29 height:29 scale:3 extraName:@"Setting@3x" fileName:@"手机全家桶"];
    [self clipImageToWidth:40 height:40 scale:2 extraName:@"Spotlight@2x" fileName:@"手机全家桶"];
    [self clipImageToWidth:40 height:40 scale:3 extraName:@"Spotlight@3x" fileName:@"手机全家桶"];
    [self clipImageToWidth:60 height:60 scale:2 extraName:@"APP@2x" fileName:@"手机全家桶"];
    [self clipImageToWidth:60 height:60 scale:3 extraName:@"APP@3x" fileName:@"手机全家桶"];
}




- (void)clipImageToWidth:(CGFloat)width height:(CGFloat)height scale:(CGFloat)scale extraName:(NSString *)extraName fileName:(NSString *)fileName{
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *filePath = [self.imagePath stringByAppendingPathComponent:fileName];
    if (![manager fileExistsAtPath:filePath]) {
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    
    NSArray *imageNames = [manager contentsOfDirectoryAtPath:self.imagePath error:nil];
    for (NSString *imageName in imageNames) {
        NSString *fullPath = [self.imagePath stringByAppendingPathComponent:imageName];
        UIImage *image = [UIImage imageWithContentsOfFile:fullPath];
        if (image) {
            if (!width || !height) {
                width = image.size.width;
                height = image.size.height;
            }
            UIImage *newImage = [UIImage resizeImage:image toWidth:width * scale height:height * scale];
            NSData *imageData = UIImagePNGRepresentation(newImage);
            NSString *imageNickName = [imageName componentsSeparatedByString:@"."].firstObject;
            NSString *newImageName;
            if (extraName) {
                newImageName = [NSString stringWithFormat:@"%@%@.png",imageNickName,extraName];
            }else{
                newImageName = [NSString stringWithFormat:@"%@.png",imageNickName];
            }
            
            [imageData writeToFile:[NSString stringWithFormat:@"%@/%@",filePath,newImageName] atomically:YES];
        }
    }
}


@end
