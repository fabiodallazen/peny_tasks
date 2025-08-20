#!/bin/bash
set -e

echo "==> Installing gems..."
bundle install

echo "==> Migrating development database..."
bundle exec rails db:migrate 2>/dev/null || true

echo "==> Preparing test database..."
RAILS_ENV=test bundle exec rails db:drop db:create db:schema:load 2>/dev/null || true

exec "$@"
