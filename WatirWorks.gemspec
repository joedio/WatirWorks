require 'rubygems'
spec = Gem::Specification.new do |s|
  s.name = 'watirworks'
  s.version = '0.1.6'
  s.summary = "WatirWorks is a testing framework and toolkit for Watir and Watir-WebDriver."
  s.description = "WatirWorks is a collection of cross-platform, cross-browser tools to enhance and expand Ruby when used with the Watir, FireWatir, or WatirWebDriver gems"
  s.files = Dir.glob("**/**/**")
  s.test_files = Dir.glob("unittests/*.rb")
  s.required_ruby_version = '>= 1.8.7'
  #s.add_dependency('commonwatir', '>= 2.0.4')
  #s.add_dependency('firewatir', '>= 1.9.4')
  #s.add_dependency('watir', '>= 2.0.4')
  s.add_dependency('watir-webdriver', '>= 0.4.1')
  s.add_dependency('roo', '>= 1.10.1')
  s.add_dependency('rautomation', '>= 0.6.3')
  s.authors = "Joe DiMauro"
  s.homepage = "http://watirworks.home.comcast.net/~watirworks/"
  s.email = "watirworks@comcast.net"
  #s.has_rdoc = true
  s.rubyforge_project =''
  s.post_install_message = "*** Please refer to the WatirWorks README Rdoc to get started. ***"
 end
