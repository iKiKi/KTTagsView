Pod::Spec.new do |spec|

  spec.name                     = 'KTTagsView'
  spec.version                  = '1.0.1'
  spec.swift_version            = '4.0'
  spec.cocoapods_version        = '>= 1.4.0'
  spec.author                   = { "Killian THORON" => "killian.thoron@gmail.com" }
  spec.social_media_url         = 'http://twitter.com/kthoron'
  spec.license                  = { :type => "MIT", :file => "LICENSE" }
  spec.homepage                 = 'https://github.com/iKiKi/KTTagsView'
  spec.source                   = { :git => "https://github.com/iKiKi/KTTagsView.git", :tag => spec.version.to_s }
  spec.summary                  = "A Swift UIView to layout your tags"
  spec.description              = <<-DESC
                                    KTTagsView offers a Swift UIView and protocols to help you to display your own custom views as "tags".
                                    This library is very useful when you need to display your tags in a UIScrollView, as it is handled by a UIView.
                                  DESC
  spec.static_framework = true
  spec.module_name              = 'KTTagsView'

  # iOS
  spec.ios.deployment_target    = "9.0"
  spec.ios.frameworks           = 'Foundation', 'UIKit'
  spec.ios.source_files         = 'Sources/*.swift'

  # tvOS
  spec.tvos.deployment_target   = "9.0"
  spec.tvos.frameworks          = 'Foundation', 'UIKit'
  spec.tvos.source_files        = 'Sources/*.swift'

end
