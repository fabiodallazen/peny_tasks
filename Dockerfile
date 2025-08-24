# syntax=docker/dockerfile:1

# ----------------------
# Base image for Ruby
# ----------------------
ARG RUBY_VERSION=3.4.5
FROM ruby:$RUBY_VERSION-slim AS base

WORKDIR /rails

# ----------------------
# Install system dependencies
# ----------------------
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential git libpq-dev curl pkg-config libyaml-dev nodejs npm && \
    npm install -g esbuild && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*

ENV RAILS_ENV=${RAILS_ENV:-production} \
    BUNDLE_PATH="/usr/local/bundle" \
    BUNDLE_WITHOUT="development:test"

# ----------------------
# Build stage (for caching and precompile)
# ----------------------
FROM base AS build

COPY Gemfile Gemfile.lock ./

RUN bundle install --jobs 4 --retry 3

COPY . .

RUN bundle exec bootsnap precompile --gemfile app/ lib/ || true

# Precompile assets only in production
RUN if [ "$RAILS_ENV" = "production" ]; then \
      SECRET_KEY_BASE=dummy bundle exec rails assets:precompile; \
    fi

# ----------------------
# Final image
# ----------------------
FROM base

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails /rails

# Create a non-root user for security
RUN groupadd --system --gid 1000 rails && \
    useradd --uid 1000 --gid 1000 --create-home --shell /bin/bash rails && \
    # Ensure directories exist and are writable by rails
    mkdir -p tmp log public vendor app/assets/builds && \
    mkdir -p app/assets/builds && \
    chown -R rails:rails tmp log public vendor app/assets/builds

USER rails

EXPOSE 3000

ENTRYPOINT ["sh", "/rails/entrypoint.sh"]

CMD ["./bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
