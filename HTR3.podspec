# coding: utf-8
#
#  Be sure to run `pod spec lint HTUI.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|


  s.name         = "HTR3"
  s.version      = "0.0.2"
  s.summary      = "高性能URLMatcher."

  s.description  = <<-DESC
                   高性能 URLMatcher .
                   DESC

  s.homepage     = "https://github.com/NEYouFan/HTR3"

  s.license      = "MIT"

  s.author       = { "netease" => "taozeyu890217@126.com"}

  s.source       = { :git => "https://github.com/NEYouFan/HTR3.git", :tag => s.version.to_s }

  s.platform     = :ios, "6.0"

  s.ios.deployment_target = "6.0"

  s.source_files  = "r3/project-mac/R3/R3/Sources/*.{h,m}",\
                    "r3/project-mac/R3/R3/Sources/include/*.h",\
                    "r3/project-mac/R3/R3/Sources/zmalloc.{c,h}"

  s.requires_arc = false

  s.public_header_files = "r3/project-mac/R3/R3/Sources/include/*.h"
  

end
