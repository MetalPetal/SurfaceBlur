//
//  MTISurfaceBlurFilter.metal
//  MetalPetal.SurfaceBlur
//
//  Created by Yu Ao on 2019/3/18.
//

#include <metal_stdlib>
using namespace metal;

namespace metalpetal {
    namespace surfaceblur {
        
        typedef struct {
            float4 position [[ position ]];
            float2 textureCoordinate;
        } MTIDefaultVertexOut;
        
        half normpdf(half x, half sigma)
        {
            return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
        }
        
        half normpdf3(half3 v, half sigma)
        {
            return 0.39894*exp(-0.5*dot(v,v)/(sigma*sigma))/sigma;
        }
        
        constant int mtiSurfaceBlurKernelRadius [[function_constant(0)]];
        fragment half4 mtiSurfaceBlur(MTIDefaultVertexOut vertexIn [[stage_in]],
                                    texture2d<half, access::sample> sourceTexture [[texture(0)]],
                                    sampler sourceSampler [[sampler(0)]],
                                    const device float * weights [[buffer(0)]],
                                    constant float & bsigma [[buffer(1)]]) {
            const int kSize = mtiSurfaceBlurKernelRadius - 1;
            
            half3 finalColor = half3(0.0);
            
            half3 c = sourceTexture.sample(sourceSampler, vertexIn.textureCoordinate).rgb;
            
            half Z = 0.0;
            
            half3 cc;
            half factor;
            half bZ = 1.0/normpdf(0.0, bsigma);
            
            for (int i=-kSize; i <= kSize; ++i)
            {
                for (int j=-kSize; j <= kSize; ++j)
                {
                    cc = sourceTexture.sample(sourceSampler, vertexIn.textureCoordinate + float2(i,j)/float2(sourceTexture.get_width(), sourceTexture.get_height())).rgb;
                    factor = normpdf3(cc-c, bsigma) * bZ * ((half)weights[kSize+j]) * ((half)weights[kSize+i]);
                    Z += factor;
                    finalColor += factor * cc;
                }
            }
            
            return half4(finalColor/Z, 1.0);
        }
    }
}
