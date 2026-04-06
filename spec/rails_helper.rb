require "simplecov"
SimpleCov.start "rails"

require "spec_helper"
ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"
require "omniauth"

OmniAuth.config.test_mode = true
OmniAuth.config.on_failure = proc { |env| OmniAuth::FailureEndpoint.new(env).redirect_to_failure }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

module AuthHelpers
  # Sign in a user by mocking the OmniAuth callback.
  # Usage: sign_in_as(user) # in request specs
  def sign_in_as(user)
    OmniAuth.config.mock_auth[user.provider.to_sym] = OmniAuth::AuthHash.new(
      provider: user.provider,
      uid: user.provider_uid,
      info: {
        nickname: user.username,
        name: user.name || user.username,
        email: user.email,
        image: user.avatar_url || "https://avatars.example.com/u/1"
      },
      credentials: { token: user.access_token || "test_token" }
    )
    get "/auth/#{user.provider}/callback"
  end
end

RSpec.configure do |config|
  config.fixture_paths = [
    Rails.root.join("spec/fixtures")
  ]

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods
  config.include AuthHelpers, type: :request
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
