# frozen_string_literal: true

# -----------------------------
# SimpleCov: must be required first
# -----------------------------
require 'simplecov'
SimpleCov.start 'rails' do
  add_filter '/bin/'
  add_filter '/db/'
  add_filter '/spec/'
  add_filter 'app/channels/application_cable/'
  add_filter 'app/helpers/application_helper.rb'
  add_filter 'app/mailers/application_mailer.rb'
  add_filter 'app/controllers/application_controller.rb'
  add_filter 'app/jobs/application_job.rb'
  minimum_coverage 99
end

# -----------------------------
# Rails environment setup
# -----------------------------
ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

# -----------------------------
# Require support files
# -----------------------------
Rails.root.glob('spec/support/**/*.rb').each { |f| require f }

# -----------------------------
# Check pending migrations
# -----------------------------
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

# -----------------------------
# RSpec configuration
# -----------------------------
RSpec.configure do |config|
  # Fixture path
  config.fixture_paths = [Rails.root.join('spec/fixtures')]

  # Use transactional fixtures
  config.use_transactional_fixtures = true

  # Infer spec type from file location
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces
  config.filter_rails_from_backtrace!
  # arbitrary gems can also be filtered
  # config.filter_gems_from_backtrace("gem name")

  # Include helpers
  config.include FactoryBot::Syntax::Methods
  config.include ActiveJob::TestHelper
end

# -----------------------------
# Shoulda Matchers configuration
# -----------------------------
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end

# -----------------------------
# Custom RSpec matchers
# -----------------------------
RSpec::Matchers.define_negated_matcher :not_change, :change
