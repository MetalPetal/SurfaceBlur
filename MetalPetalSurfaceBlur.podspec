#
# Be sure to run `pod lib lint MetalPetalSurfaceBlur.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MetalPetalSurfaceBlur'
  s.version          = '0.1.0'
  s.summary          = 'Surface Blur / Bilateral Filter for MetalPetal.'
  s.description      = 'Surface Blur / Bilateral Filter for MetalPetal.'

  s.homepage         = 'https://github.com/MetalPetal/SurfaceBlur'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yuao' => 'me@imyuao.com' }
  s.source           = { :git => 'https://github.com/MetalPetal/SurfaceBlur.git', :tag => s.version.to_s }

  s.ios.deployment_target = '11.0'
  s.macos.deployment_target = '10.13'

  s.source_files = 'SurfaceBlur/**/*'
  
  s.dependency 'MetalPetal'

end
