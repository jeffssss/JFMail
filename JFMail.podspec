Pod::Spec.new do |s|
  s.name         = "JFMail"
  s.version      = "0.0.1"
  s.summary      = "smtp client for ios."
  s.homepage     = "https://github.com/jeffssss/JFMail"
  s.ios.deployment_target = '8.0'
  s.license      = "Apache License 2.0"
  s.authors      = { "jeffssss" => "happeoo00123@163.com" }
  s.source       = { :git => "https://github.com/jeffssss/JFMail.git", :tag => "0.0.1" }
  s.source_files  = "lib/*.{h,m}"
  s.framework  = "CFNetwork","Foundation"
  s.requires_arc = true
end
