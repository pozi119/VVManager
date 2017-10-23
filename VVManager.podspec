#
# Be sure to run `pod lib lint VVManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'VVManager'
  s.version          = '2.1.0'
  s.summary          = 'ViewController manager.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       ** ViewController Manager **
                       1. Pop/Present ViewController with ClassName.
                       2. Set ViewController properties with NSDictionary key-value.
                       DESC

  s.homepage         = 'https://github.com/pozi119/VVManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'pozi119' => 'pozi119@163.com' }
  s.source           = { :git => 'https://github.com/pozi119/VVManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VVManager/**/*'
  
  # s.resource_bundles = {
  #   'VVManager' => ['VVManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
