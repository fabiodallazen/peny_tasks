#!/bin/bash
set -e

if [ "$RAILS_ENV" = "production" ]; then
  # --------------------------
  # Production setup
  # --------------------------
  echo "==> Creating/migrating production database if needed..."
  bundle exec rails db:create 2>/dev/null || true
  bundle exec rails db:migrate 2>/dev/null || true
else
  # --------------------------
  # Development / Test setup
  # --------------------------
  echo "==> Installing gems..."
  bundle install

  echo "==> Creating/migrating development database..."
  bundle exec rails db:create db:migrate 2>/dev/null || true

  echo "==> Preparing test database..."
  RAILS_ENV=test bundle exec rails db:drop db:create db:schema:load 2>/dev/null || true

  # Install JS dependencies
  echo "==> Installing JS packages..."
  npm install

  # Install JS dependencies
  echo "==> Resetting assets..."
  bin/rails assets:clobber || true

  # Run initial JS build
  echo "==> Running JS build..."
  npm run build

  # Verify build
  if [ ! -f app/assets/builds/application.js ]; then
    echo "ERROR: application.js not found after build"
    exit 1
  fi

  if [ "$RAILS_ENV" = "development" ]; then
    echo "==> Starting dev environment..."
    exec bin/dev
  fi
fi

# --------------------------
# Execute the main command
# --------------------------
exec "$@"
