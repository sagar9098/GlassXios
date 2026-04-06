#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint glassx_ios.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'glassx_ios'
  s.version          = '1.0.0'
  s.summary          = 'A production-ready Flutter package providing native-powered iOS Liquid Glass UI.'
  s.description      = <<-DESC
A production-ready Flutter package providing native-powered iOS Liquid Glass UI
(UIVisualEffectView via PlatformView) with adaptive BackdropFilter fallback on
Android and Web. Write once, get stunning glass UI everywhere.
                       DESC
  s.homepage         = 'https://github.com/your-org/glassx_ios'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
