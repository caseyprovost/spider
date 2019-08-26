# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.3"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 6.0.0"
# Use Puma as the app server
gem "puma", "~> 3.11"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", ">= 1.4.2", require: false
gem "graphql"
gem "httparty"
gem "sentry-raven"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "pry-rails"
  gem "pry-byebug"
  gem "dotenv-rails"
  gem "standard"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem "guard"
  gem "rspec-rails"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "webmock"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
