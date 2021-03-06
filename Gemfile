source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3.6'
# For HackerRank compatibility
gem 'sprockets', '~> 3.7.2'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Efficient, convenient, non-intrusive JSONAPI framework for Rails
gem 'jsonapi-rails'
# Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications
gem 'puma', '~> 5.2', '>= 5.2.2'
# I18n
gem 'i18n'
gem 'rails-i18n'

group :development, :test do
  # Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema
  gem 'annotate', '~> 3.1', '>= 3.1.1'
  # Helps to kill N+1 queries and unused eager loading
  gem 'bullet', '~> 6.1', '>= 6.1.4'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry', '~> 0.14.0'
  gem 'rspec_junit_formatter'
  gem 'rspec-rails', '~> 5.0'
  gem 'rubocop', '~> 1.12', '>= 1.12.1'
  gem 'shoulda-matchers', '~> 4.5', '>= 4.5.1'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
