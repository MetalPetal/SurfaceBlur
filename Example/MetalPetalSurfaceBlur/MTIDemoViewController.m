//
//  MTIDemoViewController.m
//  MetalPetalSurfaceBlur
//
//  Created by yuao on 03/19/2019.
//  Copyright (c) 2019 yuao. All rights reserved.
//

#import "MTIDemoViewController.h"
@import MetalPetal;
@import MetalPetalSurfaceBlur;

@implementation MTIDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MTIImageView *imageView = [[MTIImageView alloc] initWithFrame:self.view.bounds];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:imageView];
    
    //Photo by Ben Scott on Unsplash. https://unsplash.com/photos/tWb7IsL9CnY
    MTIImage *inputImage = [[MTIImage alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"ben-scott-1176654-unsplash" withExtension:@"jpg"] options:@{MTKTextureLoaderOptionSRGB: @NO} alphaType:MTIAlphaTypeAlphaIsOne];
    
    MTISurfaceBlurFilter *filter = [[MTISurfaceBlurFilter alloc] initWithRadius:10];
    filter.inputImage = inputImage;
    imageView.image = filter.outputImage;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
