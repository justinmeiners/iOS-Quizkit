Pod::Spec.new do |s|
s.name         = "iOS-QuizKit"
s.version      = "0.0.1"
s.license      = 'MIT' 
s.summary      = "Fork of iOS-QuizKit for development"
s.homepage     = "https://github.com/LostStudent/iOS-Quizkit"
s.author       = { "Christian French" => "christian.french@kiddicare.com" }
s.platform     = :ios, '7.0'
s.source       = { :git => "https://github.com/LostStudent/iOS-Quizkit.git"}
s.source_files = 'Source/*.{h,m}'
s.resources    = "Assets/*.{xib}"
end
