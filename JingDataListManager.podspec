#
# Be sure to run `pod lib lint JingDataListManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JingDataListManager'
  s.version          = '0.1.0'
  s.summary          = 'A short description of JingDataListManager.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.homepage         = 'https://github.com/tianziyao/JingDataListManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tianziyao' => 'tianziyao@jingdata.com' }
  s.source           = { :git => 'https://github.com/tianziyao/JingDataListManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JingDataListManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JingDataListManager' => ['JingDataListManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'JingDataNetwork'
  s.dependency 'MJRefresh', '3.1.15.6'
  s.dependency 'JingDataStateSwitch'
end
