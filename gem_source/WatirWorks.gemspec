require 'rubygems'
spec = Gem::Specification.new do |s|
  s.name = 'watirworks'
  s.version = '0.2.0'
  s.license = 'MIT'
  s.authors = "Joe DiMauro"
  s.homepage = "http://watirworks.home.comcast.net/~watirworks/"
  s.email = "watirworks@comcast.net"
  s.rubyforge_project =''
  s.summary = "WatirWorks is a testing framework and toolkit for WatirWebdriver."
  s.description = "WatirWorks is a collection of cross-platform, cross-browser tools to enhance and expand Ruby when used with WatirWebdriver."
  s.files = Dir.glob("**/**/**")
  #s.has_rdoc = true
  #s.test_files = Dir.glob("unittests/*.rb")
  s.required_ruby_version = '>= 1.9.3'
  s.add_runtime_dependency 'roo', '~> 2.1', '>= 2.1.1'
  s.add_runtime_dependency 'roo-xls', '~> 1.0', '>= 1.0.0'
  s.add_runtime_dependency 'rautomation', '~> 0.17', '>= 0.17.0'
  s.add_runtime_dependency 'watir-webdriver', '~> 0.8', '>= 0.8.0'
  s.post_install_message = "*** Please refer to the WatirWorks README Rdoc to get started. ***"
 end
