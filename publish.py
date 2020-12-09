import os

def logo():
    print("""

  #####   #######   #####                                  
 #     #     #     #     #  #####   ######   ####    ####  
 #           #     #        #    #  #       #    #  #      
 #           #      #####   #    #  #####   #        ####  
 #           #           #  #####   #       #            # 
 #     #     #     #     #  #       #       #    #  #    # 
  #####      #      #####   #       ######   ####    ####  

    """)
    return


def selectOperator():
    
    print("")
    print("* 1. 直接push到私有仓库（CTSpecs）")
    print("* 2. 提交到develop分支")
    print("* 3. 提交到main分支")
    print("* 4. 提交到main并push到私有仓库（CTSpecs）")
    print("")
    return


def isRepoDirty():
    return os.system("git diff --quiet") != 0


def switchBranch(branch):

    branchType = int(branch)

    if branchType in [1, 2, 3] == False:
        print("")
        print("* 1. 停留在当前分支")
        print("* 2. 切换到develop分支")
        print("* 3. 切换到main分支")
        print("")

        # 输入切换的选项
        branchType = int(input("请选择要切换到的分支:"))
    else:
        print("切换到的类型为：%d", branchType)

    # 切换到指定分支
    if branchType == 2:
        os.system("git checkout develop")
    elif branchType == 3:
        os.system("git checkout main")
    else:
        print("停留在当前分支。")
    return


def pushToGit(branchName):

    pushBranch = branchName
    if len(branchName) <= 0:
        pushBranch = "main"
    else:
        pushBranch = branchName

    print("开始发布到当前分支 ...")
    os.system("git status")
    os.system("git add --all")
    msg = input("\n请输入提交信息(默认为'日常提交'):")
    print("提交信息：%s" % msg)
    os.system("git commit -m '%s'" % ("日常提交" if msg.isspace() else msg))
    os.system("git pull origin %s" % pushBranch)
    os.system("git push origin %s" % pushBranch)
    print("已经上传到%s成功了" % pushBranch)
    return


def addGitTag(tag):

    os.system("git tag %s" % tag)
    os.system("git push origin --tags")
    return


def pushToMain():
    switchBranch(3)
    pushToGit("main")
    return

# 提交到main，并且打tag，推送到CTSpecs
def pushToMainAndPrivateSpecs():
    switchBranch(3)
    pushToGit("main")

    tag = str(input("输入要发布的版本号(跳过设置 Tag 请直接回车)："))
    if len(tag) <= 0:
        print("输入版本号为空，跳过设置 Tag 步骤")
    else:
        addGitTag(tag)
    pushToPrivateSpecs()


# 直接push到CTSpecs
def pushToPrivateSpecs():

    checkCommand = "pod spec lint --sources='https://github.com/ours-curiosity/CTSpecs,https://github.com/CocoaPods/Specs' --allow-warnings"
    pushCommand = "pod repo push CTSpecs %s.podspec --sources='https://github.com/ours-curiosity/CTSpecs,https://github.com/CocoaPods/Specs' --allow-warnings --use-modular-headers"%podName
    updatePirvateRepo = "pod repo update CTSpecs"
    checkRet = os.system(checkCommand)
    if checkRet != 0:
        print("校验出错，请检查spec文件是否配置正确")
        exit - 1
    else:
        pushRet = os.system(pushCommand)
        if pushRet != 0:
            print("上传失败！")
            exit - 1
        else:
            print("上传完成！！")
            os.system(updatePirvateRepo)
    return


if __name__ == "__main__":
    # 提示
    logo()
    # 输入库名称
    podName = str(input("请输入要发布的pod库名称:"))
    # 输入操作类型
    selectOperator()
    # 输入发布类型
    option = input("请选择发布的类型(默认为1):")
    # option 不输入时默认为1，否则为输入内容
    if len(option) <= 0:
        option = 1
    else:
        option = int(option)

    # 去发布
    if option == 1:
        pushToPrivateSpecs()
    elif option == 2:
        pushToGit("develop")
    elif option == 3:
        pushToGit("main")
    elif option == 4:
        pushToMainAndPrivateSpecs()
    else:
        print("🤨 -> 请输入正确的选项!!")
