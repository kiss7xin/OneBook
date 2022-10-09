#source 'https://cdn.cocoapods.org/'

workspace './OneBook.xcworkspace'
project './OneBook/OneBook.xcodeproj'

platform :ios, '14.0'
use_frameworks!

# ignore all warnings from all dependencies
inhibit_all_warnings!

def thirdparty_pods
  pod 'SwiftTheme'
  pod 'Moya'
  pod 'Kingfisher'
  pod 'SnapKitExtend'
  pod 'RxSwift', '= 5.1.1'
  pod 'RxRelay', '= 5.1.1'
  pod 'RxCocoa', '= 5.1.1'
  pod 'RxDataSources', '= 4.0.1'
  
  # ------ 其他
  # 常用扩展
  pod 'SwifterSwift', '~> 5.2.0'
  # 资源文件
  pod 'R.swift', '~> 5.2.2'
  
end


target 'OneBook' do
  
  thirdparty_pods

end
