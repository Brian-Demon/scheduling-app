class UsersController < ApplicationController
  before_action :set_user

  def account
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_back(fallback_location: @user, notice: "Account successfully updated.") }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :account, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :title)
  end
end
