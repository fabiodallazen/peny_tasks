# frozen_string_literal: true

require_relative 'boot'
require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Load environment variables from .env files only in development and test.
# In production, we rely on real environment variables instead of Dotenv.
if %w[development test].include?(Rails.env)
  require 'dotenv'
  Dotenv.load(".env.#{ENV.fetch('RAILS_ENV', nil)}", '.env')
end

module PenyTasks
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Customize generators to rspec
    config.generators do |g|
      g.test_framework :rspec
      g.helper false
      g.routing_specs false
      g.system_tests false
      g.view_specs false
    end
  end
end
