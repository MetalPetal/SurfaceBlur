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
        
        float normpdf(float x, float sigma)
        {
            return 0.39894*exp(-0.5*x*x/(sigma*sigma))/sigma;
        }
        
        float normpdf3(float3 v, float sigma)
        {
            return 0.39894*exp(-0.5*dot(v,v)/(sigma*sigma))/sigma;
        }
        
        constant int mtiSurfaceBlurKernelRadius [[function_constant(0)]];
        fragment float4 mtiSurfaceBlur(MTIDefaultVertexOut vertexIn [[stage_in]],
                                    texture2d<float, access::sample> sourceTexture [[texture(0)]],
                                    sampler sourceSampler [[sampler(0)]],
                                    const device float * weights [[buffer(0)]],
                                    constant float & bsigma [[buffer(1)]]) {
            const int kSize = mtiSurfaceBlurKernelRadius - 1;
            
            float3 finalColor = float3(0.0);
            
            float3 c = sourceTexture.sample(sourceSampler, vertexIn.textureCoordinate).rgb;
            
            float Z = 0.0;
            
            float3 cc;
            float factor;
            float bZ = 1.0/normpdf(0.0, bsigma);
            
            for (int i=-kSize; i <= kSize; ++i)
            {
                for (int j=-kSize; j <= kSize; ++j)
                {
                    cc = sourceTexture.sample(sourceSampler, vertexIn.textureCoordinate + float2(i,j)/float2(sourceTexture.get_width(), sourceTexture.get_height())).rgb;
                    factor = normpdf3(cc-c, bsigma) * bZ * weights[kSize+j] * weights[kSize+i];
                    Z += factor;
                    finalColor += factor * cc;
                }
            }
            
            return float4(finalColor/Z, 1.0);
        }
    }
}
