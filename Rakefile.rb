require 'rubygems'
Gem::manage_gems
require 'rake/gempackagetask'
require File.dirname(__FILE__) + "/lib/riconv/version"

# GEM SETUP
spec = Gem::Specification.new do |s|
  s.name              = "riconv"
  s.version           = Iconv::VERSION::STRING
  s.author            = "Vincent Landgraf"
  s.email             = "fmq-3z@gmx.net"
  s.homepage          = "http://riconv.rubyforge.org/"
  s.platform          = Gem::Platform::RUBY
  s.summary           = "rIconv is a ruby iconv implementation"
  s.files             = FileList["{docs,lib,test}/**/*"].exclude("rdoc").to_a
  s.require_path      = "lib"
  s.autorequire       = "riconv"
  s.test_file         = "tests/basic_test.rb"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ['README']
end
# GEM SETUP END

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar = true
end

desc "runs all the test cases"
task :test do
  sh "ruby tests/basic_test.rb"
end

task :default => [:test]
