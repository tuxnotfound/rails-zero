class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)

    if user.save
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "Welcome, #{user.name}!"
    else
      redirect_to root_path, alert: "Sign in failed. Please try again."
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "You've been signed out."
  end

  def failure
    redirect_to root_path, alert: "Authentication failed: #{params[:message]}"
  end
end
