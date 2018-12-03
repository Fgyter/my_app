source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.1'
gem 'rails', '~> 5.2.1'
gem 'puma', '~> 3.11'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'sprockets-rails'
gem 'jquery-rails'
gem 'nodejs-rails', '~> 0.0.1'
gem 'bootsnap', '>= 1.1.0', require: false

gem 'bootstrap', '~> 4.1.3'
gem 'activeadmin'
gem 'devise','~> 4.5.0'
gem "paperclip", "~> 6.0.0"
# gem 'aws-sdk', '~> 2.3'
gem 'aws-sdk-s3'
gem 'carrierwave', '~> 1.2.3'
gem "fog-aws"
gem 'stripe'
gem 'html2slim', '~> 0.2.0'
gem 'slim'
gem 'kaminari'
gem 'bootstrap4-kaminari-views'
gem 'ransack'
gem 'aasm', '~> 4.11'
gem 'rails-i18n'

group :development do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'sqlite3'
  gem 'pry'
end

group :production do
   gem 'pg'
   gem 'rails_12factor'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'chromedriver-helper'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
