#
# Be sure to run `pod lib lint ios_base_foundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ios_base_foundation'
  s.version          = '0.5.0'
  s.summary          = 'iOS 基础加速库.'

  s.description      = <<-DESC
  你可以使用base_foundation来构建新的app. ios 10.0, swift 5
                       DESC

  s.homepage         = 'https://github.com/ours-curiosity/ios_base_foundation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ours-curiosity' => 'ours.curiosity@gmail.com' }
  s.source           = { :git => 'https://github.com/ours-curiosity/ios_base_foundation.git', :tag => '0.5.0' }
  s.social_media_url = 'https://ours-curiosity.github.io/'

  s.ios.deployment_target = '10.0'
  s.swift_version = "5.0"

  s.source_files = 'ios_base_foundation/Classes/**/*'
  
  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'

  #依赖第三方库
  s.dependency 'SnapKit', '= 5.0.1'
  s.dependency 'Toast-Swift', '= 5.0.1'

end
