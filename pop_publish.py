import os

checkCommand = "pod spec lint --sources='https://github.com/ours-curiosity/CTSpecs,https://github.com/CocoaPods/Specs'"
pushCommand = "pod repo push CTSpecs BaseFoundation.podspec --sources='https://github.com/ours-curiosity/CTSpecs,https://github.com/CocoaPods/Specs'"
updatePirvateRepo = "pod repo update CTSpecs"

checkRet = os.system(checkCommand)

if checkRet != 0 :
    print("校验出错，请检查spec文件是否配置正确")
    exit -1
else: 
    pushRet = os.system(pushCommand)
    if pushRet != 0 :
        print("上传失败！")
        exit -1
    else:
        print("上传完成！！")
        os.system(updatePirvateRepo)
    