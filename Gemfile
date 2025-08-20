# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.4.5' # Adjust to match the Ruby version in your Docker setup

# --- Core dependencies ---
gem 'bootsnap', '~> 1.18', '>= 1.18.6', require: false # Faster boot time
gem 'pg', '~> 1.6', '>= 1.6.1' # PostgreSQL adapter
gem 'puma', '~> 6.6', '>= 6.6.1' # Web server
gem 'rails', '~> 7.2', '>= 7.2.2.2' # Rails framework

# --- Frontend / Hotwire ---
gem 'importmap-rails', '~> 2.2', '>= 2.2.2' # Importmap for JS
gem 'stimulus-rails', '~> 1.3', '>= 1.3.4'  # Stimulus controllers
gem 'turbo-rails', '~> 2.0', '>= 2.0.16'    # Turbo Drive + Turbo Frames

group :development, :test do
  gem 'debug', platforms: %i[mri windows], require: 'debug/prelude' # Debugging tool

  # --- Code quality / security ---
  gem 'brakeman', require: false # Security scanner
  gem 'rubocop', '~> 1.79', require: false # Ruby linter
  gem 'rubocop-factory_bot', '~> 2.27', require: false # FactoryBot-specific cops
  gem 'rubocop-rails', '~> 2.32', require: false # Rails-specific cops
  gem 'rubocop-rspec', '~> 3.6', require: false # RSpec-specific cops

  # --- Testing ---
  gem 'factory_bot_rails', '~> 6.5'       # Factories for test data
  gem 'faker', '~> 3.5'                   # Fake data generator
  gem 'rspec-rails', '~> 7.1', '>= 7.1.1' # RSpec test framework
  gem 'shoulda-matchers', '~> 6.5'        # Extra matchers for RSpec
  gem 'simplecov', '~> 0.22.0', require: false # Code coverage
end

group :development do
  gem 'bullet', '~> 8.0'       # Detect N+1 queries
  gem 'dotenv-rails', '~> 3.1' # Environment variables support
  gem 'web-console' # Interactive console in browser errors
end
