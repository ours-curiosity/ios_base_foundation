#
# Be sure to run `pod lib lint BaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'BaseKit'
    s.version          = '0.1.0'
    s.summary          = 'iOS 基础加速库.'
    
    s.description      = <<-DESC
    你可以使用base_foundation来构建新的app. ios 10.0, swift 5
    DESC
    #指定swift版本
    s.swift_version = "5.0"
    s.homepage         = 'https://github.com/ours-curiosity/ios_base_foundation'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'ours-curiosity' => 'ours.curiosity@gmail.com' }
    s.source           = { :git => 'https://github.com/ours-curiosity/ios_base_foundation.git', :tag => s.version.to_s }
    s.social_media_url = 'https://ours-curiosity.github.io/'
    s.ios.deployment_target = '10.0'
    # source_files 源文件目录以及子目录
    s.source_files = 'BaseKit/Classes/**/*'
    s.resource_bundles = {
        'BaseKit' => ['BaseKit/Assets/*.png']
    }
    s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'
    #依赖第三方库
    s.dependency 'SnapKit', '~> 5.0'
    s.dependency 'Toast-Swift', '~> 5.0'

    s.static_framework = true
end
