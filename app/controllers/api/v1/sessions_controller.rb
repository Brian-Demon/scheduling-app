class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = auth ? authenticate_with_omniauth(auth) : authenticate_with_form(params)
    
    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome #{user.first_name}!"
    else
      flash[:alert] = "Invalid email or password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end

  def authenticate_with_omniauth(auth)
    User.find_or_create_with_omniauth(auth)
  end

  def authenticate_with_form(params)
    user = User.find_by(email: params[:email])
    return false unless user.present?
    user.authenticate(params[:password])
  end
end