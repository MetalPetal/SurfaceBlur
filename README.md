# SurfaceBlur

Surface Blur / Bilateral Filter for MetalPetal.

## Preview

![Preview](Assets/preview.jpg)

*Photo by Ben Scott on Unsplash. https://unsplash.com/photos/tWb7IsL9CnY*

## Usage

```Objective-C
MTISurfaceBlurFilter *filter = [[MTISurfaceBlurFilter alloc] initWithRadius:...];
filter.threshold = ...;
filter.inputImage = inputImage;
MTIImage *outputImage = filter.outputImage;
```

## Install

```
pod 'MetalPetalSurfaceBlur', :git => 'https://github.com/MetalPetal/SurfaceBlur.git'

# Optional
pod 'MetalPetal/Swift'
```

## License

MIT.
