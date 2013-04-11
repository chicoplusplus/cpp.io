source "http://gemcutter.org"
source 'https://rubygems.org'
ruby '1.9.3'

gem 'rails', '3.2.13'
group :production do
  gem 'newrelic_rpm'
end

group :development, :test do
  gem 'pry-rescue'
  gem 'pry-doc'
  gem 'pry'
end

group :test do
  gem 'forgery'
  gem 'rb-fsevent', :require => false
  gem 'kicker', :require => false
  gem 'spin', :require => false
  gem 'turn'
  gem 'launchy'
  gem 'capybara-webkit'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_girl'
  gem 'minitest-metadata', :require => false
  gem 'minitest-matchers'
  gem 'minitest'
end


# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'pg'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'jquery-rails'
  gem 'zurb-foundation'
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'yui-compressor'
end

# gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

gem "unicorn"
gem "aws-sdk", "~> 1.3.4"
gem "simple_form", "~> 2.1.0"
gem "role_model"
gem "strong_parameters"
gem "devise"
gem "cancan"
gem "carrierwave"
gem "meta_search", ">= 1.1.0.pre"
gem "activeadmin", "~> 0.5.1"
gem "exception_notification", "2.6.1"
gem "fog"
gem "remotipart", :github => "mattolson/remotipart"
gem "mail_form"
gem "mini_magick"