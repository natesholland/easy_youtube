Gem::Specification.new do |s|
  s.name        = 'easy_youtube'
  s.version     = '1.0.2'
  s.date        = '2015-10-29'
  s.summary     = "Youtube helper functions"
  s.description = "This is a simple Gem for dealing with youtube videos"
  s.authors     = ["Nate Holland"]
  s.email       = 'natesholland@gmail.com'
  s.files       = ["lib/easy_youtube.rb"]
  s.homepage    =
    'https://github.com/natesholland/easy_youtube'
  s.license       = 'MIT'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'rake'
  s.required_ruby_version = ">= 1.9.2"
end
