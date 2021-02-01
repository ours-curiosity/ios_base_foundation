# CTBaseFoundation ChangeLog
----

### 0.7.6.0
> 1.  `UIButton` 添加计算`Title`宽度的扩展方法

### 0.7.5.0
> 1. `DebugPrint()` 添加控制是否打印的参数`canPrint:`

### 0.7.3.2
> 1. `UIFit` 添加标签栏相关高度api

### 0.7.3.1
>* 1. 修改`CTImageType`的可见性

### 0.7.3.0
>* 1. 修改`Data+ImageType`方法前缀，防止冲突
>* 2. 添加根据图片类型获取`contentType`和`extensionName`方法

### 0.7.2.0
>* 1. 添加`Data+ImageType`，根据二进制文件判断图片类型

### 0.7.1.7
>* 1. 为`Reachability`添加`CT`前缀，防止冲突
>* 2. 完善`AppDeveice`中关于网络类型和运营商的获取

### 0.7.1.2
>* 1. 添加`CTPermission`，获取权限的快捷方法

### 0.7.1.1
>* 1. 修改`.gitignore`文件，添加对`Pods`文件夹的忽略，删除冗余文件
>* 2. 修改`UIViewExtension`文件中的`cornerRadius`方法名，添加对`ct_`前缀，防止与其他库产生冲突
>* 3. 修改`UserDefaultWrapper`可见性

### 0.7.0.6
>* 1. 移除`UIImageExtensions`中对`bundle`的`load()`,避免控制台中打印的警告信息

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
