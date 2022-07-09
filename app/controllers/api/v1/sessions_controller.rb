module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :verify_authenticity_token
      def create
        auth = request.env["omniauth.auth"]
        user = authenticate_with_omniauth(auth) if auth
        
        if user
          if session[:user_id] == user.id
            render json: { error: 'Already logged in' }
          else
            session[:user_id] = user.id
            render json: { message: "#{user.employee_name} logged in" }
          end
        else
          render json: { error: 'Session not created' }, status: 422
        end
      end

      def destroy
        if session[:user_id].nil?
          render json: { error: 'No current session' }, status: 422
        else
          session[:user_id] = nil
          render json: { message: 'Logged out' }
        end
      end

      def authenticate_with_omniauth(auth)
        User.find_or_create_with_omniauth(auth)
      end

      private

      def session_params
        params.require(:session).permit(:email, :password, :password_confirmation)
      end
    end
  end
end