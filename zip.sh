PROJECT_NAME=${PWD##*/}

CURRENT_POD_VERSION=$(cat $PROJECT_NAME.podspec | grep 's.version' | grep -o '[0-9]*\.[0-9]*\.[0-9]*')

LIB_NAME="${PROJECT_NAME}_${CURRENT_POD_VERSION}"
if [ -f $LIB_NAME.zip ]; then
	rm -fr $LIB_NAME.zip
fi

zip -r ./$LIB_NAME.zip ./$PROJECT_NAME/* ./LICENSE ./README.md

if [ "$?" -eq "0" ];then
	echo "pack file $CUR_FILE into $LIB_NAME.zip file ok~!"
else
	echo "Error:Pack file into $LIB_NAME.zip failed~!"
	exit 1
fi

# # 上传到服务器

# sshpass -p "111111" scp $LIB_NAME.zip binaryadmin@ios-pod.baidao.com:/opt/binaryfiles/

# ret=$?

# if [ "$ret" -ne "0" ];then
# 	exit 1
# fi

# # 临时上传到公司的gitlab上，再后期考虑删除掉，走服务器最好
echo 'git clone binaryfiles'
git clone https://git.caibeike.net/mobile_ios/binaryfiles.git
echo 'cp $LIB_NAME.zip to binaryfiles'
cp -r $LIB_NAME.zip binaryfiles/
echo 'cd to binaryfiles'
cd binaryfiles
echo 'commit to binaryfiles'
git add $LIB_NAME.zip
git commit -m "add $LIB_NAME.zip file"
echo 'git push binaryfiles to remote'
git push -u origin master

echo 'rm temp binaryfiles dir'
cd ../
rm -rf binaryfiles

# 临时拉取二进制的路径，后期接入网络后考虑删除掉
echo 'git pull binaryfiles'
cd /Users/cbk/CBKComponents/binaryfiles/
git pull
echo 'git pull binaryfiles success!'