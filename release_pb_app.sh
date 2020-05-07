PROJECT_NAME=${PWD##*/}

APP_NAME="CBKApp"

APP_PATH="$APP_NAME/workspace/Podfile"

# LATEST_TAG=$(git tag | xargs -I@ git log --format=format:"%ai @%n" -1 @ | sort | awk '{print $4}' | tail -2 | sed -n '2p')
# LATEST_PREVIOUS_TAG=$(git tag | xargs -I@ git log --format=format:"%ai @%n" -1 @ | sort | awk '{print $4}' | tail -2 | sed -n '1p')

if [ ! -d "$APP_NAME" ]; then
  git clone git@git.caibeike.net:pb/CBKApp.git
fi

cd CBKApp
git checkout dev
git pull
cd ..

ORIGIN_POD_VERSION=$(cat $APP_PATH | grep $PROJECT_NAME | grep -o '[0-9]*\.[0-9]*\.[0-9]*')
CURRENT_POD_VERSION=$(cat $PROJECT_NAME.podspec | grep 's.version' | grep -o '[0-9]*\.[0-9]*\.[0-9]*')
CURRENT_POD_URL=$(cat $PROJECT_NAME.podspec | grep 's.homepage' | grep -o "'.*'" | sed "s/'//g")

echo "This current version is $CURRENT_POD_VERSION"

ORIGIN_POD_VALUE=$(cat $APP_PATH | grep $PROJECT_NAME)
NEW_POD_VALUE="    pod '$PROJECT_NAME', '$CURRENT_POD_VERSION'"

echo "ORIGIN_POD_VALUE: $ORIGIN_POD_VALUE"
echo "NEW_POD_VALUE: $NEW_POD_VALUE"

COMMIT_LOG='commit.log'

git log $ORIGIN_POD_VERSION..$CURRENT_POD_VERSION --graph > $COMMIT_LOG

echo "" | cat >> $COMMIT_LOG
echo "The merge request is from $PROJECT_NAME" | cat >> $COMMIT_LOG
cat $COMMIT_LOG

mv $COMMIT_LOG CBKApp/workspace/$COMMIT_LOG

if [[ $ORIGIN_POD_VALUE ]]; then
	echo "s/$ORIGIN_POD_VALUE/$NEW_POD_VALUE/g"

	sed -i "" "s/$ORIGIN_POD_VALUE/$NEW_POD_VALUE/g" $APP_PATH
else
	sed -i "" "/target 'CBKApp' do/ a\\
$NEW_POD_VALUE
" $APP_PATH
fi

echo "========================================================="
cat $APP_PATH
echo "========================================================="

cd CBKApp/workspace

BRANCH_NAME=CIPodfileUpdpateWith$PROJECT_NAME@$CURRENT_POD_VERSION

git checkout -b $BRANCH_NAME

# pod repo update CBKPrivateRepo

# rm Podfile.lock

# if [[ $(which podh) ]]; then
# 	echo 'podh install'
# 	podh install
# else
# 	echo 'pod install'
# 	pod install
# fi

git config --get user.name 
git config --get user.email
git add Podfile
git commit -F $COMMIT_LOG
git remote -v
git push --set-upstream origin $BRANCH_NAME

cd ..

pwd

ls -l

if [[ -f "merge_request.sh" ]]; then
	echo "Try to Add merge_request with CBKApp"
	sh merge_request.sh "CI_Update_Podfile_$PROJECT_NAME@$CURRENT_POD_VERSION" dev "$CURRENT_POD_URL/merge_requests?scope=all&state=merged"
fi

cd ..
