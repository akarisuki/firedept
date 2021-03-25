class TweetsController < ApplicationController
  #一通りのログイン機能を作ったら追加する
  before_action :authenticate_user!

  def index
  end

  def new
    @tweet = Tweet.new
    @tags  = Tweet.includes([:taggings]).tag_counts_on(:tags)
  end

  def create
    
  end

  def show
    @user = @tweet.user
  end


end


 