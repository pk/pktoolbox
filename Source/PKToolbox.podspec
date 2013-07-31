#
# Be sure to run `pod spec lint PKToolbox.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about the attributes see http://docs.cocoapods.org/specification.html
#
Pod::Spec.new do |s|
  s.name         = "PKToolbox"
  s.version      = "2.0.0"
  s.summary      = "Pavel's utilities for iOS."
  s.description  = <<-DESC
                   DESC
  s.homepage      = "http://pavelkunc.cz/PKToolbox"
  s.author        = { "Pavel Kunc" => "pavel.kunc@gmail.com" }
  s.source        = { :git => "https://github.com/pk/pktoolbox.git", :tag => "2.0.0" }
  s.platform      = :ios, '6.0'
  s.source_files  = 'Source', 'Source/**/*.{h,m}'
  s.exclude_files = 'Source/Exclude'
  s.frameworks    = 'Foundation', 'UIKit'
  s.requires_arc  = true
end
