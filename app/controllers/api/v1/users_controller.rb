module Api
  module V1
    class UsersController < ApplicationController
      # skip_before_action :verify_authenticity_token
      before_action :set_user, only: [:show, :update, :destroy]

      def index
        users = User.all
        render json: UserSerializer.new(users).serialized_json, status: :ok
      end

      def show
        if @user
          render json: UserSerializer.new(@user).serialized_json, status: :ok
        else
          render json: { error: "User not found" }, status: 422
        end
      end

      def create
        user = User.new(user_params)
        if user.save
          render json: { message: "#{user.employee_name} successfully created" }, status: :created
        else
          render json: { error: "Unable to create user" }, status: :unprocessable_entity
        end
      end

      def update
        if @user.update(user_params)
          render json: { message: "#{@user.employee_name} successfully updated" }, status: :ok
        else
          render json: { error: "Unable to update user" }, status: :unprocessable_entity
        end
      end

      def destroy
        user_name = @user.employee_name if @user
        if @user.destroy
          render json: { message: "#{user_name} successfully deleted" }, status: :ok
        else
          render json: { error: "User not found" }, status: :unprocessable_entity
        end
      end

      private

      def set_user
        @user = User.find(params[:id])
      end

      def user_params
        params.require(:user).permit(:email, :first_name, :last_name, :title, :role, :uid, :provider)
      end
    end
  end
end
