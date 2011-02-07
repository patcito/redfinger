require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "redfinger"
    gem.summary = %Q{A Ruby WebFinger client.}
    gem.description = %Q{A Ruby Webfinger client}
    gem.email = "michael@intridea.com"
    gem.homepage = "http://github.com/mbleigh/redfinger"
    gem.authors = ["Michael Bleigh"]
    gem.add_dependency "rest-client", ">= 1.5.0"
    gem.add_dependency "nokogiri", ">= 1.4.0"
    gem.add_dependency "hashie"
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_development_dependency "webmock"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "redfinger #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
