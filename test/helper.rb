require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
if RUBY_VERSION =~ /\A1\.9/ && !defined?(JRUBY_VERSION)
	require 'simplecov'
	SimpleCov.start
end

require 'test/unit'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'protective'

DB_CONFIG = { :adapter => (defined?(JRUBY_VERSION) ? 'jdbcsqlite3' : 'sqlite3'),
              :database => File.join('test', 'protective_plugin.sqlite3.db')}


def load_schema
  ActiveRecord::Base.establish_connection(DB_CONFIG)
  load(File.join(File.dirname(__FILE__), "schema.rb"))
end


class Test::Unit::TestCase
end
