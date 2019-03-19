//
//  MTISurfaceBlurFilter.h
//  MetalPetal.SurfaceBlur
//
//  Created by Yu Ao on 2019/3/18.
//

#import <Foundation/Foundation.h>
#import <MetalPetal/MetalPetal.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTISurfaceBlurFilter : NSObject <MTIUnaryFilter>

- (instancetype)init NS_UNAVAILABLE;

+ (instancetype)new NS_UNAVAILABLE;

- (instancetype)initWithRadius:(int)radius; // Kernel size = radius * 2 - 1

@property (nonatomic) float threshold; //0-255 default 10

@end

NS_ASSUME_NONNULL_END
