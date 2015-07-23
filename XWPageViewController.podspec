Pod::Spec.new do |s|
  s.name         = "XWPageViewController"
  s.version      = "0.0.1"
  s.summary      = "The easier way to use PageViewController"
  s.homepage     = "https://github.com/shnuzxw/XWPageViewController"
  s.license      = "MIT"
  s.authors      = { 'shnuzxw' => '1661162303@qq.com'}
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/shnuzxw/XWPageViewController2.git", :tag => s.version }
  s.source_files = "XWPageViewController/XWPageViewController/*.{h,m}"
  s.resource     = ""
  s.requires_arc = true
end
