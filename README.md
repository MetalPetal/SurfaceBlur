# SurfaceBlur

Surface Blur / Bilateral Filter for MetalPetal.

![Preview](Assets/preview.jpg)

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
