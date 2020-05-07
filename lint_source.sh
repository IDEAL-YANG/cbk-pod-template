SOURCES='https://git.caibeike.net/mobile_ios/cbk_private_repo.git,https://cdn.cocoapods.org'
IS_SOURCE=1 pod lib lint --sources=$SOURCES --verbose --fail-fast --use-libraries --allow-warnings