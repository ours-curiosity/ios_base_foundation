import os

print("""
 ___   _____  ___                       
(  _`\(_   _)(  _`\                     
| ( (_) | |  | (_) )   _ _   ___    __  
| |  _  | |  |  _ <' /'_` )/',__) /'__`\\
| (_( ) | |  | (_) )( (_| |\__, \(  ___/
(____/' (_)  (____/'`\__,_)(____/`\____)                                                                     
  """)
print("")
print("* 1. 提交到develop分支")
print("* 2. 提交到main分支")
print("* 3. 提交到私有仓库（CTSpecs）")
print("")

option = int(input("请选择发布的类型:"))

if option == 1: 
    print("开始发布到develop ...")
    os.system("git status")
    os.system("git add --all")
    msg = input("\n请输入提交信息(默认为'日常提交'):")
    print("提交信息：%s"%msg)
    os.system("git commit -m '%s'"% ("日常提交" if msg.isspace() else msg))
    os.system("git pull origin develop")
    os.system("git push origin develop")
    print("已经上传到'develop'分支成功了")
else: 
    print("其他选项：%d" % open)
# checkCommand = "pod spec lint --sources='https://github.com/ours-curiosity/CTSpecs,https://github.com/CocoaPods/Specs'"
# pushCommand = "pod repo push CTSpecs BaseFoundation.podspec --sources='https://github.com/ours-curiosity/CTSpecs,https://github.com/CocoaPods/Specs'"
# updatePirvateRepo = "pod repo update CTSpecs"

# checkRet = os.system(checkCommand)

# if checkRet != 0 :
#     print("校验出错，请检查spec文件是否配置正确")
#     exit -1
# else: 
#     pushRet = os.system(pushCommand)
#     if pushRet != 0 :
#         print("上传失败！")
#         exit -1
#     else:
#         print("上传完成！！")
#         os.system(updatePirvateRepo)
    