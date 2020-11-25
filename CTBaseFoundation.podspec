#
# Be sure to run `pod lib lint ios_base_foundation.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CTBaseFoundation'
  s.version          = '0.6.6'
  s.summary          = 'iOS 基础加速库.'

  s.description      = <<-DESC
  你可以使用CTBaseFoundation来快速构建新的app. ios 10.0, swift 5
                       DESC

  s.homepage         = 'https://github.com/ours-curiosity/ios_base_foundation'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ours-curiosity' => 'ours.curiosity@gmail.com' }
  s.source           = { :git => 'https://github.com/ours-curiosity/ios_base_foundation.git', :tag => s.version.to_s }
  s.social_media_url = 'https://ours-curiosity.github.io/'
  s.requires_arc     = true
  s.ios.deployment_target = '10.0'
  s.swift_version = "5.0"
  
  s.source_files = 'ios_base_foundation/Classes/**/*'
  
  # Core
  s.subspec 'Core' do |sp|
    sp.source_files  = 'ios_base_foundation/Classes/Core/*'
  end
  
  # Extensions
  s.subspec 'Extension' do |sp|
    sp.source_files  = 'ios_base_foundation/Classes/Core/*', 'ios_base_foundation/Classes/Extension/**/*'
  end
  
  # UIKit Extensions
  s.subspec 'UIKit' do |sp|
    sp.source_files  = 'ios_base_foundation/Classes/Core/*', 'ios_base_foundation/Classes/Extension/UIKit/*'
  end

end
