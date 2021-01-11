# CTBaseFoundation ChangeLog
----

### 0.7.0.5
>* 1. 添加`String`计算所占尺寸方法`textRect(attributes:, maxSize:) -> CGRect`

### 0.7.0.4
>* 1. 移除 UIImage扩展中的`imageNamed(_ name:, bundleForClass:, bundleName:)`方法中`bundle.load()`方法，防止控制台警告
>* 2. 完善`.gitignore`文件

### 0.7.0.3
>* 1. 修改Bundle扩展中`bundle(className:, bundleName: )`方法的参数名，`className`->`classType`
>* 2. 添加`Int`转`String`方法

### 0.7.0.2
>* 1. 添加快捷生成Module中Bundle的扩展方法`bundle(className:, bundleName: )`
>* 2. 修改脚本，添加快速提交私有Pod repo 的选项
