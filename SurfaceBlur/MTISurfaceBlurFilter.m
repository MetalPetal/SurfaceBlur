//
//  MTISurfaceBlurFilter.m
//  MetalPetal.SurfaceBlur
//
//  Created by Yu Ao on 2019/3/18.
//

#import "MTISurfaceBlurFilter.h"

static float MTIGaussianDistributionPDF(float x, float sigma) {
    return 1.0/sqrt(2 * M_PI * sigma * sigma) * exp((- x * x) / (2 * sigma * sigma));
}

@interface MTISurfaceBlurFilter ()

@property (nonatomic, readonly, strong) MTIRenderPipelineKernel *kernel;

@property (nonatomic, readonly, strong) MTIVector *weights;

@end

@implementation MTISurfaceBlurFilter
@synthesize inputImage = _inputImage;
@synthesize outputPixelFormat = _outputPixelFormat;

- (instancetype)initWithRadius:(int)radius {
    if (self = [super init]) {
        _threshold = 10;
        int weightsCount = radius * 2 - 1;
        assert(weightsCount > 0);
        float weights[weightsCount];
        for (NSInteger i = 0; i < radius; i += 1) {
            weights[radius - 1 + i] = weights[radius - 1 - i] = MTIGaussianDistributionPDF(i, radius);
        }
        _weights = [MTIVector vectorWithFloatValues:weights count:weightsCount];
        MTLFunctionConstantValues *constants = [[MTLFunctionConstantValues alloc] init];
        [constants setConstantValue:&radius type:MTLDataTypeInt withName:@"metalpetal::surfaceblur::mtiSurfaceBlurKernelRadius"];
        _kernel = [[MTIRenderPipelineKernel alloc]
                   initWithVertexFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:MTIFilterPassthroughVertexFunctionName]
                   fragmentFunctionDescriptor:[[MTIFunctionDescriptor alloc] initWithName:@"metalpetal::surfaceblur::mtiSurfaceBlur" constantValues:constants libraryURL:MTIDefaultLibraryURLForBundle([NSBundle bundleForClass:self.class])]
                   vertexDescriptor:nil
                   colorAttachmentCount:1
                   alphaTypeHandlingRule:MTIAlphaTypeHandlingRule.generalAlphaTypeHandlingRule];
    }
    return self;
}

- (MTIImage *)outputImage {
    if (!_inputImage) {
        return nil;
    }
    return [_kernel applyToInputImages:@[_inputImage]
                            parameters:@{@"weights": _weights,
                                         @"bsigma": @((float)(_threshold/255.0 * 2.0))}
               outputTextureDimensions:_inputImage.dimensions
                     outputPixelFormat:_outputPixelFormat];
}

@end
