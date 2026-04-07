source "https://rubygems.org"

ruby "~> 3.3"

gem "rails", "~> 8.1"
gem "propshaft"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"

# Auth
gem "omniauth-github", "~> 2.0"
gem "omniauth-rails_csrf_protection"

# Environment variables
gem "dotenv-rails"

# Background jobs (no Redis)
gem "solid_cache"
gem "solid_queue"

# Boot performance
gem "bootsnap", require: false

gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"

  # Testing
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"

  # Linting
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
  gem "simplecov", require: false
end
