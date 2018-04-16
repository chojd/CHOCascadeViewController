#
# Be sure to run `pod lib lint CHOCascadeViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CHOCascadeViewController'
  s.version          = '0.1.1'
  s.summary          = 'A short description of CHOCascadeViewController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/chojd/CHOCascadeViewController'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chojd' => 'jingda.cao@mfashion.com.cn' }
  s.source           = { :git => 'https://github.com/chojd/CHOCascadeViewController.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.subspec 'Defines' do |ss|
    ss.source_files = 'Sources/Defines/*'
  end

  s.subspec 'Controllers' do |ss|
    ss.source_files = 'Sources/Controllers/*'
  end

  s.subspec 'Views' do |ss|
    ss.source_files = 'Sources/Views/*'
  end

  s.subspec 'Models' do |ss|
    ss.source_files = 'Sources/Models/*'
  end

  s.frameworks = 'UIKit'

end
