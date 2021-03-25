class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, except: %i[index]
  
  def index
    @users = User.all
  end

  def edit 
  end

  def show
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username,:email)
  end
end
