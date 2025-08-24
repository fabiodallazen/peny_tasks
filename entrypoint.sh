#!/bin/bash
set -e

# ----------------------
# Entrypoint for Docker
# ----------------------

echo "==> Installing gems..."
bundle install

# ----------------------
# Database setup for dev
# ----------------------
if [ "$RAILS_ENV" = "development" ]; then
  echo "==> Migrating development database..."
  bundle exec rails db:migrate 2>/dev/null || true

  echo "==> Preparing test database..."
  RAILS_ENV=test bundle exec rails db:drop db:create db:schema:load 2>/dev/null || true
fi

# ----------------------
# Run dev or production
# ----------------------
if [ "$RAILS_ENV" = "development" ] && [ "$1" = "bin/dev" ]; then
  echo "==> Running bin/dev (Rails + npm build:watch)..."
  exec bin/dev
else
  # Default production command
  exec "$@"
fi
