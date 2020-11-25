# ios_base_foundation

[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/ios_base_foundation.svg)](https://img.shields.io/cocoapods/v/ios_base_foundation.svg)
[![Platform](https://img.shields.io/cocoapods/p/ios_base_foundation.svg?style=flat)](https://ios_base_foundation.github.io/Alamofire)
[![Build Status](https://travis-ci.org/ios_base_foundation/SnapKit.svg)](https://travis-ci.org/ios_base_foundation/ios_base_foundation)
[![Sponsors](https://opencollective.com/ios_base_foundation/sponsors/badge.svg)](https://opencollective.com/ios_base_foundation/sponsors/badge.svg)
[![LICENSE](https://img.shields.io/cocoapods/l/ios_base_foundation.svg)](https://img.shields.io/cocoapods/l/ios_base_foundation.svg)
[![Swift](https://img.shields.io/badge/Swift-5.0-orange.svg)](https://swift.org)
[![Xcode](https://img.shields.io/badge/Xcode-11.4-blue.svg)](https://developer.apple.com/xcode)

#### ⚠️ **To use with Swift 5.x please ensure you are using >= 0.5.0** ⚠️

本项目最开始 基于 [SwifterSwift](https://github.com/SwifterSwift/SwifterSwift/blob/master/README.md)

- ios 基础库
  `BaseFoundation`

## 要求：
- swift:5.0
- iOS：10.0

## 使用：

> 1. 首先添加私有库`repo`到`pod`
```
pod repo add CTSpecs https://github.com/ours-curiosity/CTSpecs.git
```
> 2. 在`Podfile` 中添加私有库的源`source`
```
source 'https://github.com/ours-curiosity/CTSpecs'
```
> 3. 添加以下语句到`Podfile`文件
```
pod 'BaseFoundation' 
```

###  只想导入最基础的功能(Core)：
```
pod 'BaseFoundation/Core'
```

###  只导入所有扩展(Extensions)：
```
pod 'BaseFoundation/Extension' 
```

###  只导入UIKit相关扩展(UIKit)：
```
pod 'BaseFoundation/UIKit' 
```

## 备注：
* 1.无论导入全部还是部分功能，都会导入`Core`相关部分。
* 2.发现库版本号与github上最新版本不一致时请`pod update`。
* 3.发现问题请提交issue。

## License

BaseUIWidget is available under the MIT license. See the LICENSE file for more info.
