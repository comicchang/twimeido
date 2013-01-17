source 'http://rubygems.org'

gem 'blather', :require => 'blather/client'
gem 'twitter-stream', :require => 'twitter/json_stream', :git => 'git://github.com/jimmyxu/twitter-stream.git'
gem 'oauth'
gem 'twitter_oauth'
gem 'geokit'
gem 'grackle', :git => 'git://github.com/jimmyxu/grackle.git'
gem 'mongo_mapper'
gem 'bson_ext'
gem 'activesupport'
gem 'actionpack', :require => 'action_view'
gem 'hashie'
gem 'yajl-ruby', :require => 'yajl/json_gem'
gem 'googl'
platforms :mri_18 do
  gem 'SystemTimer'
end

group :development do
  gem 'awesome_print', :require => 'ap'
  gem 'irbtools', :require => nil
  gem 'irbtools-more', :require => nil
  gem 'irb_rocket', :require => nil

  gem 'rspec'
  gem 'yard'
  gem 'bundler'
  gem 'jeweler'
  gem (RUBY_VERSION >= "1.9" ? "simplecov" : "rcov")
end
