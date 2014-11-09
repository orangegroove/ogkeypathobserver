#
# Be sure to run `pod lib lint OGKeyPathObserver.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "OGKeyPathObserver"
  s.version          = "0.1.0"
  s.summary          = "Simple, no-fuss KVO decorator."
  s.description      = <<-DESC
                        Simple library that wraps KVO with a block syntax and automatic observer removal.
                       DESC
  s.homepage         = "https://github.com/orangegroove/OGKeyPathObserver"
  s.license          = 'MIT'
  s.author           = { "Jesper" => "jesper@orangegroove.net" }
  s.source           = { :git => "https://github.com/orangegroove/OGKeyPathObserver.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/jskrufve'
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.source_files     = 'Pod/Classes'
  s.frameworks       = 'Foundation'
end
