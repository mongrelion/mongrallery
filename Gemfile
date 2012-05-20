source 'https://rubygems.org'

gem 'rails', '3.2.3'
gem 'jquery-rails'
gem 'sqlite3', :platforms => :ruby
gem 'devise'
gem 'slim-rails'
gem 'inherited_resources'
gem 'draper'
gem 'carrierwave'
gem 'mini_magick'

platform :jruby do
  gem 'jruby-openssl'
  gem 'activerecord-jdbcsqlite3-adapter'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'faker'
  gem 'pry'
  gem 'database_cleaner'
end

group :test do
  gem 'capybara'
  gem 'capybara-webkit'
  gem 'fabrication'
  gem 'launchy'
  gem 'minitest'
end

group :production do
  gem 'puma'
end
