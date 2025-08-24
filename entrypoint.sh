#!/bin/bash
set -e

# ----------------------
# Dev environment setup
# ----------------------
if [ "$RAILS_ENV" = "development" ]; then
  echo "==> Installing gems..."
  bundle install

  echo "==> Installing JS packages..."
  yarn install

  echo "==> Running first JS build..."
  yarn build

  echo "==> Migrating development database..."
  bundle exec rails db:migrate 2>/dev/null || true

  echo "==> Preparing test database..."
  RAILS_ENV=test bundle exec rails db:drop db:create db:schema:load 2>/dev/null || true

  # Run bin/dev if requested
  if [ "$1" = "bin/dev" ]; then
    exec bin/dev
  fi
fi

# For production or other commands
exec "$@"
