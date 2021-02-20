class TweetsController < ApplicationController
  before_action :set_tweet, only: [:edit, :destroy, :show, :update]
  before_action :authenticate_user!,only:  [:new, :create, :edit, :update, :destroy]
  
  def index
    @tweets = Tweet.includes(:user).order('updated_at desc').page(params[:page]).per(5)
    if params[:tag_name]
      @tweets = Tweet.includes(:user).order('updated_at desc').page(params[:page]).per(5).tagged_with("#{params[:tag_name]}")
    end
    return nil if params[:keyword] == ""
    @allTags = Tweet.tag_counts_on(:tags)
    @tags = @allTags.where(['name LIKE ?', "%#{params[:keyword]}%"])
    respond_to do |format|
      format.html
      format.json
    end
  end

  def likes
    @tweets = Tweet.includes(%i[taggings user]).order('likes_count desc').page(prams[:page]).per(10)
  end

  def taglist
    @tags = Tweet.tag_counts_on(:tags)
  end

  def new
      @tweet = Tweet.new
      @tags= Tweet.tag_counts_on(:tags)
      @tag_select = ["rails","java"]
  end

  def create
    @tweet = Tweet.create(tweet_params)
    if @tweet.save
      redirect_to root_path, notice: '投稿しました'
    else
      flash.now[:alert] = 'メッセージを入力して下さい。'
      render :new
    end
  end

  def edit
    if @tweet.user_id != current_user.id
      redirect_to root_path, notice: "不正な操作です"
    end
    return nil if params[:keyword] == ""
    @allTags = Tweet.tag_counts_on(:tags)
    @tags = @allTags.where(['name LIKE ?', "%#{params[:keyword]}%"])
    respond_to do |format|
      format.html
      format.json
  end

  def update
    @tweet.update(tweet_params)
    if @tweet.save
      redirect_to tweet_path(@tweet.id), notice: '編集しました'
    else
      flash.now[:alert] = 'メッセージを入力して下さい。'
      render :edit
    end
  end

  def show
    @comment = Comment.new
    @comments = @tweet.comments.includes(:user).order('created_at desc')
    @user = @tweet.user
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path, notice: '削除しました'
  end

  private

  def tweet_params
    params.require(:tweet).permit(:title, :txet, :image, :video, :tag_list).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def move_to_index
    unless current_user
    redirect_to root_path, notice: 'アカウント登録またはログインして下さい'
    end
  end
end
