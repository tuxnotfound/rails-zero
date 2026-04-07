Rails.application.routes.draw do
  root "home#index"

  # OAuth — callback path matches the provider name (e.g. /auth/github/callback)
  get  "/auth/:provider/callback", to: "sessions#create"
  get  "/auth/failure",            to: "sessions#failure"
  delete "/sign_out",              to: "sessions#destroy", as: :sign_out

  # Dashboard (authenticated)
  get "/dashboard", to: "dashboard#index", as: :dashboard

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
