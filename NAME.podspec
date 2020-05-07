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
  s.summary          = "#{s.name}, 组件模块."

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

  s.homepage         = "https://git.caibeike.net/mobile_ios/#{s.name}"
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '${USER_NAME}' => '${USER_EMAIL}' }

  s.ios.deployment_target = '8.0'

  # 暂时本地路径，后期换成网络url
  cbk_zipURL="file:///Users/Ideal-company-taidu/Git/Sourcetree/Gitlab-Self/IDEALComponents/binaryfiles/#{s.name}.zip"
  if ENV['IS_SOURCE'] || ENV["#{s.name}_SOURCE"]
      s.source           = { :git => "https://git.caibeike.net/mobile_ios/#{s.name}.git", :tag => s.version.to_s }
  else
      s.source           = { :http => cbk_zipURL}
  end

  if ENV['IS_SOURCE'] || ENV["#{s.name}_SOURCE"]
      s.prepare_command = <<-'END'
        test -f download_zip.sh && sh download_zip.sh s.name
      END
      puts '-------------------------------------------------------------------'
      puts "Notice:#{s.name} is source now"
      puts '-------------------------------------------------------------------'
      s.source_files = "#{s.name}/Classes/**/*"
  else
      puts '-------------------------------------------------------------------'
      puts "Notice:#{s.name} is binary now"
      puts '-------------------------------------------------------------------'
      s.source_files = "#{s.name}/Classes/*.h"
      s.ios.vendored_libraries = "#{s.name}/lib/lib#{s.name}.a"
  end
  s.preserve_paths = "#{s.name}/lib/lib#{s.name}.a","#{s.name}/Classes/**/*", "download_zip.sh"
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.public_header_files = "#{s.name}/Classes/*.h"
  # s.prefix_header_file = "#{s.name}/Classes/#{s.name}-Prefix.pch"
  
  # s.resource_bundles = {
  #   "#{s.name}" => ["#{s.name}/Assets/*.png"]
  # }
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
