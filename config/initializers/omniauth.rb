# OmniAuth provider configuration.
# By default GitHub is configured. Swap in any other OmniAuth provider gem
# (e.g. omniauth-google-oauth2, omniauth-twitter2) by replacing :github below
# and adjusting the scope/client_options accordingly.
#
# oauth2 gem 2.0+ adds response_type=code to authorize URLs.
# Some providers (GitHub newer OAuth Apps) return 404 when that param is
# present — the monkeypatch below removes it at the source.
module OAuth2
  module Strategy
    class AuthCode
      def authorize_params(params = {})
        params.merge("client_id" => @client.id)
      end
    end
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github,
           ENV.fetch("GITHUB_CLIENT_ID", nil),
           ENV.fetch("GITHUB_CLIENT_SECRET", nil),
           scope: "user:email",
           client_options: { auth_scheme: :request_body }
end

OmniAuth.config.allowed_request_methods = [ :post ]
OmniAuth.config.silence_get_warning = true

if Rails.env.development?
  OmniAuth.config.allowed_request_methods = [ :post, :get ]
end
