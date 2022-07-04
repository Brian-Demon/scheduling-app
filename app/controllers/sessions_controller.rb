class SessionsController < ApplicationController
  DEV_INTUIT_BASE_URL = "https://sandbox-accounts.platform.intuit.com"
  PROD_INPUT_BASE_URL = "https://accounts.platform.intuit.com"
  INTUIT_USERINFO_API_ENDPOINT = "/v1/openid_connect/userinfo"

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
    provider = auth["provider"]
    if provider == "intuit"
      token = auth["credentials"]["token"]
      conn = Faraday.new(DEV_INTUIT_BASE_URL) do |conn|
        conn.request :authorization, 'Bearer', token
      end
      response = conn.get(INTUIT_USERINFO_API_ENDPOINT)
      body = JSON.parse(response.body)
      auth["info"]["email"] = body["email"]
      auth["info"]["first_name"] = body["givenName"]
      auth["info"]["last_name"] = body["familyName"]
      auth["uid"] = body["sub"]
      byebug
    end
    User.find_or_create_with_omniauth(auth)
  end

  def authenticate_with_form(params)
    user = User.find_by(email: params[:email])
    return false unless user.present?
    user.authenticate(params[:password])
  end
end