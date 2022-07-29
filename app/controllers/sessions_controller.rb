class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:destroy]

  def create
    auth = request.env["omniauth.auth"]
    @user = authenticate_with_omniauth(auth) if auth
    if @user.persisted?
      if logged_in?
        redirect_to root_path, { notice: "Already logged in" }
      else
        login!
        redirect_to root_path, { notice: "Logged In" }
      end
    else
      redirect_to root_path, { notice: "Session not created" }
    end
  end

  def destroy
    if logged_in?
      logout!
      render json: { logged_in: false, csrf: form_authenticity_token }
    else
      render json: { error: "No Session" }, status: 422
    end
  end

  def is_logged_in?
    if logged_in? && current_user
      render json: {
        logged_in: true,
        user: current_user,
      }
    else
      render json: {
        logged_in: false,
        message: "Session not created",
      }
    end
  end

  private

  def authenticate_with_omniauth(auth)
    User.find_or_create_with_omniauth(auth)
  end
end
