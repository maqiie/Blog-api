#!/usr/bin/env bash
# Exit on error
set -o errexit

# Install Bundler gems
bundle install

# Run database migrations
rails db:migrate

# Seed the database
rails db:seed
