module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token
      before_action :set_user, only: [:show, :update]

      def new
        @user = User.new
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: { message: "#{user.employee_name} Successfully Created" }
        else
          render json: { error: 'Unable to create user' }, status: 422
        end
      end

      def index
        users = User.all
        render json: UserSerializer.new(users).serialized_json
      end

      def show
        user = User.find(user_params[:id])
        if user
          render json: UserSerializer.new(user).serialized_json
        else
          render json: { error: 'User not found' }, status: 422
        end
      end

      def update
        if user.update(user_params)
          render json: { message: "#{user.employee_name} Successfully Update" }
        else
          render json: { error: 'Unable to update user' }, status: 422
        end
      end

      def destroy
        user = User.find(params[:id])
        user_name = user.employee_name if user
        if user.destroy
          render json: { message: "#{user_name} Successfully Deleted" }
        else
          render json: { error: 'User not found' }, status: 422
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
      end
    end
  end
end
