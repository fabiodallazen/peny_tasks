# frozen_string_literal: true

namespace :lint do
  desc 'Run all linters: Ruby, ERB, JS'
  task all: %i[ruby erb js]

  desc 'Run Ruby linter'
  task ruby: :environment do
    puts 'Running RuboCop...'
    sh 'bundle exec rubocop'
  end

  desc 'Run ERB linter'
  task erb: :environment do
    puts 'Running ERB-Lint...'
    sh 'bundle exec erb_lint app/views'
  end

  desc 'Run JS linter'
  task js: :environment do
    puts 'Running ESLint...'
    sh 'npm run lint'
  end
end
