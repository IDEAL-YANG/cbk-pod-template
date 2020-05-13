#
# Be sure to run `pod lib lint ${POD_NAME}.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = '${POD_NAME}'
  s.version          = '0.1.0'
  s.summary          = '${POD_NAME}, 组件模块.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CBK私有库, 主要是为了组件化整个工程.
目标是: 一处编辑，处处可用！
  级别: 基础组件（可选值有: 业务组件、功能组件、基础组件）
  负责: XXX(理由具体库具体写)
                       DESC

  s.homepage         = 'https://git.caibeike.net/mobile_ios/${POD_NAME}'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '${USER_NAME}' => '${USER_EMAIL}' }

  s.ios.deployment_target = '8.0'

  if ENV['IS_SOURCE'] == '1' || ENV['cbk_navigator_SOURCE'] == '1'
      puts '-------------------------------------------------------------------'
      puts 'Notice:${POD_NAME} is source now'
      puts '-------------------------------------------------------------------'
      s.source       = { :git => 'https://git.caibeike.net/mobile_ios/${POD_NAME}.git', :tag => s.version.to_s }

      s.source_files = '${POD_NAME}/Classes/**/*'
  else
      puts '-------------------------------------------------------------------'
      puts 'Notice:${POD_NAME} is binary now'
      puts '-------------------------------------------------------------------'
      s.source       = { :http => 'http://172.10.3.123:8000/${POD_NAME}_0.1.0.zip' }# 暂时是局域网http路径，后期换成互联网url

      s.source_files = '${POD_NAME}/Classes/*.h'
      s.ios.vendored_libraries = '${POD_NAME}/lib/lib${POD_NAME}.a'
  end

  s.preserve_paths = '${POD_NAME}/lib/lib${POD_NAME}.a','${POD_NAME}/Classes/**/*'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.public_header_files = '${POD_NAME}/Classes/*.h'
  # s.prefix_header_file = '${POD_NAME}/Classes/${POD_NAME}-Prefix.pch'
  
  # s.resource_bundles = {
  #   '${POD_NAME}' => ['${POD_NAME}/Assets/*.png']
  # }
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
