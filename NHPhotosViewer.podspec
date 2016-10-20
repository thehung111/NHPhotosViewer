#
#  Be sure to run `pod spec lint NHPhotosViewer.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.

Pod::Spec.new do |s|

  
  s.name         = "NHPhotosViewer"
  s.version      = "0.1.2"
  s.summary      = "Simple photo viewer written in Swift."

  s.description  = <<-DESC
                   Simple photos viewer written in Swift
                   DESC

  s.homepage     = "https://github.com/thehung111/NHPhotosViewer"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license          = {:type => "MIT", :file => "LICENSE"}
 
  s.author             = { "Ngo Hung" => "thehung111@gmail.com" }
  

  s.platform     = :ios, "8.0"

  
  s.source       = { :git => "https://github.com/thehung111/NHPhotosViewer.git", :tag => "#{s.version}" }


  s.source_files  = "NHPhotosViewer/NHPhotosViewer/**/*.{h,swift}"
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  s.framework = "CFNetwork"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "Kingfisher", "~> 3.1"
  s.xcconfig    = { 'SWIFT_VERSION' => '3.0' }
 

end
