Pod::Spec.new do |s|
  s.name         = "VOVCManager"
  s.version      = "2.0.9"
  s.summary      = "a ViewController manager"
  s.description  = <<-DESC
                    ** ViewController Manager **
                    1. Pop/Present ViewController with ClassName.
                    2. Set ViewController properties with NSDictionary key-value.
                   DESC

  s.homepage     = "https://github.com/pozi119/VOVCManager"
  s.license      = "Apache 2.0"
  s.author       = { "pozi119" => "pozi119@163.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/pozi119/VOVCManager.git", :tag => s.version.to_s }
  s.source_files  = "VOVCManager", "VOVCManager/*.{h,m}"
end
