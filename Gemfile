source "http://rubygems.org"
# Add dependencies required to use your gem here.
# Example:
#   gem "activesupport", ">= 2.3.5"

gem "activerecord"

# Add dependencies to develop your gem here.
# Include everything needed to run rake, tests, features, etc.
group :development do
  gem "bundler", "~> 1.0.0"
  gem "jeweler", "~> 1.5.2"
  gem "rdoc"
  
  gem "rcov", :platform => :ruby_18
  gem "simplecov", :platform => :ruby_19

	gem 'sqlite3', :platforms => :ruby
	gem 'jdbc-sqlite3', '3.6.14.2.056', :platforms => :jruby
	gem 'activerecord-jdbcsqlite3-adapter', :platforms => :jruby
end
