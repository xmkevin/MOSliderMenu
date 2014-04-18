#
#  Be sure to run `pod spec lint MOSliderMenu.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "MOSliderMenu"
  s.version      = "1.0.0"
  s.summary      = "A snapseed like image adjustment menu"

  s.description  = <<-DESC
                   It is a menu with the same look as snapseed image adjustment menu.
                   DESC
  s.homepage     = "https://github.com/xmkevin/MOSliderMenu"
  s.screenshots  = "https://github.com/xmkevin/MOSliderMenu/blob/master/Resources/screenshot.png"
  s.license      = 'MIT (example)'
  s.author       = { "xmkevin" => "gaoyq@live.cn" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/xmkevin/MOSliderMenu.git", :tag => "v1.0.0" }
  s.source_files  = 'Classes', 'Classes/**/*.{h,m}'
  s.requires_arc = true

end
