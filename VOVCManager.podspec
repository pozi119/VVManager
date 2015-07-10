Pod::Spec.new do |s|
  s.name         = "VOVCManager"
  s.version      = "1.0.0"
  s.summary      = "iOS页面管理器,支持URLScheme方式跳转"
  s.homepage     = "https://github.com/pozi119/VOVCManager"
  s.license      = { :type => 'Apache 2.0', :file => 'LICENSE.md' }
  s.author       = { "Valo Lee" => "pozi119@163.com" }
  s.source       = { :git => "https://github.com/pozi119/VOVCManager.git", :tag => "v1.0.0" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'VOVCManager/*.{h,m}'
  s.framework  = ''
end
