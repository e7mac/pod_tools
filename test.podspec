Pod::Spec.new do |s|
  s.name             = "TPGameAbstract"
  s.version          = "0.1.11"
  s.summary          = "TPGameAbstract is the base class for all the TidePool games"
  s.homepage         = "http://tidepool.co"
  s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "e7mac" => "mayank.ot@gmail.com" }
  s.source           = { :git => "https://github.com/tidepool/TPGameAbstract.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tidepool'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/ios/**/*'
  s.resources = 'Assets/**/*'

  s.dependency 'TPBadges'
end
