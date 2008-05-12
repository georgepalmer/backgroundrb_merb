require 'rubygems'
require 'rake/gempackagetask'

PLUGIN = "backgroundrb_merb"
NAME = "backgroundrb_merb"
VERSION = "1.0.3"
AUTHOR = "George Palmer"
EMAIL = "george.palmer@gmail.com"
HOMEPAGE = "not yet"
SUMMARY = "Merb plugin that provides backgroundrb"

spec = Gem::Specification.new do |s|
  s.name = NAME
  s.version = VERSION
  s.platform = Gem::Platform::RUBY
  s.has_rdoc = true
  s.extra_rdoc_files = ["README", "LICENSE", 'TODO']
  s.summary = SUMMARY
  s.description = s.summary
  s.author = AUTHOR
  s.email = EMAIL
  s.homepage = HOMEPAGE
  s.add_dependency('merb', '>= 0.9.2')
  s.add_dependency('packet', '>= 0.1.5')
  s.add_dependency('chronic', '>= 0.2.3')
  s.require_path = 'lib'
  s.autorequire = PLUGIN
  s.files = %w(LICENSE README Rakefile TODO) + Dir.glob("{config,generators,lib,script,server,specs}/**/*")
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

task :install => [:package] do
  sh %{sudo gem install pkg/#{NAME}-#{VERSION}}
end

namespace :jruby do
  desc "Run :package and install the resulting .gem with jruby"
  task :install => :package do
    sh %{#{SUDO} jruby -S gem install pkg/#{NAME}-#{Merb::VERSION}.gem --no-rdoc --no-ri}
  end
end