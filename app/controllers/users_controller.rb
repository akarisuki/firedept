class UsersController < ApplicationController
  before_action :set_user, except: [:index, ]

  def index
    @users = User.all
  end

  def show
    @tweets  =  @user.tweets.order('updated_at desc').page(params[:page]).per(5)
  end

  def likes
    @user = User.find(params[:id])
  end

  def following
    @users = @user.following
  end

  def followers
    @users = @user.followers
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
