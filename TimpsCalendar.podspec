#
# Be sure to run `pod lib lint TimpsCalendar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#


Pod::Spec.new do |s|
  s.name             = 'TimpsCalendar'
  s.version          = '0.1.0'
  s.summary          = 'TimpsCalendar helps you to pick the date from calendar. This library constains of two different types of calendars(normal, quick).'
  s.swift_version    = '5.0'

  s.description      = <<-DESC
  'TimpsCalendar helps you to pick the date from calendar. This library constains of two different types of calendars(normal, quick). You can chooose based on your requirment. Itss designed based on iOS standards.'
                       DESC

  s.homepage         = 'https://github.com/HazarathReddy/TimpsCalendar'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'HazarathReddy' => 'hazarathgm@gmail.com' }
  s.platform         = :ios, '10.0'
  s.source           = { :git => 'https://github.com/HazarathReddy/TimpsCalendar.git', :tag => s.version.to_s }
  s.source_files     = 'TimpsCalendar/*.swift'

end
