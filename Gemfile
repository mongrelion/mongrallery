source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
gem 'devise'
gem 'slim-rails'
gem 'inherited_resources'
gem 'carrierwave'
gem 'mini_magick'
gem 'jruby-openssl', :platform => :jruby

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier',     '>= 1.0.3'
end

group :test, :development do
  gem 'database_cleaner'
  gem 'faker'
  gem 'pry'
  gem 'sqlite3', :platform => :ruby
  gem 'activerecord-jdbcsqlite3-adapter', :platform => :jruby
end

group :development do
  gem 'foreman'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'fabrication'
  gem 'launchy'
  gem 'minitest'
  gem 'rake'
end

group :production do
  gem 'unicorn'
  gem 'pg'
end
