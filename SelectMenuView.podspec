# pod trunk push SelectMenuView.podspec

Pod::Spec.new do |spec|

  spec.name         = "SelectMenuView"
  spec.version      = "1.0.2"
  spec.summary      = "一个比较简单的弹窗，自用"

  spec.description  = <<-DESC
                     Computes the meaning of life.
                     Features:
                     1. Is self aware
                     ...
                     42. Likes candies.
                   DESC

  spec.homepage     = "https://github.com/xzw717/SelectMenuView"

  spec.license      = "MIT"

  spec.author             = { "谢增文" => "xiezw94@126.com" }

  spec.platform     = :ios
 
  spec.source       = { :git => "https://github.com/xzw717/SelectMenuView.git", :tag => "#{spec.version}" }

  spec.source_files  = "SelectMenu/**/*.{h,m}"


end
