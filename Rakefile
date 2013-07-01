require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'



task :default => :test


require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "protective"
  gem.homepage = "http://github.com/codez/protective"
  gem.license = "MIT"
  gem.summary = %Q{Protect records from being destroyed in a declarative way}
  gem.description = %Q{Protect records from being destroyed in a declarative way. Simply add 'protect_if :dont_delete, "Record is marked as not deletable"' to your ActiveRecord model. Your record will no be destroyed and the given message is added to the errors object.}
  gem.email = "spam@codez.ch"
  gem.authors = ["Pascal Zumkehr"]
  # Include your dependencies below. Runtime dependencies are required when using your gem,
  # and development dependencies are only needed for development (ie running rake tasks, tests, etc)
  gem.add_runtime_dependency 'activerecord'
  #  gem.add_development_dependency 'rspec', '> 1.2.3'
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test

if RUBY_VERSION == '1.8.7' && !defined?(JRUBY_VERSION)
	require 'rcov/rcovtask'
	Rcov::RcovTask.new do |test|
	  test.libs << 'test'
	  test.pattern = 'test/**/*_test.rb'
	  test.verbose = true
	end
end

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "protective #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('LICENSE*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
