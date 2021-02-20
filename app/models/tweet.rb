class Tweet < ApplicationRecord

  #search  
  def self.search(search)
    if search
      Tweet.where('title Like(?)',"%#{search}%")
    else
      Tweet.all
    end
  end
  
  #likes
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  #tweets
  #monut_uploader :avatar, AvatarUploader
  validates :text, presence: true, length: { maximum: 1500 }
  validates :title, presence: true, length: { maximum: 1500 }

  belongs_to :user
  #comments
  has_many :comments, dependent: :destroy

  #notification
  has_many :notification, dependent: :destroy

  def create_notification_like!(current_user)
    #すでにいいねされてるか検索
    temp = Notification.where(["visitor_id = ? and visited_id = ? and tweet_id = ? and action = ?", current_user.id, user_id, id,'like'])
    #いいねされてなかったら通知を作成
    if temp.blank?
      notification = current_user.active_notfication.new(
        tweet_id: id,
        visited_id: user_id,
        action: 'like'
      )
      #自分の投稿にはいいね通知済みにする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    #　自分以外にコメントしている人を全て取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(tweet_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    #まだ誰もコメントしていない場合は投稿者に通知を送る
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    #コメントは複数回することが考えられるため、一つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      tweet_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      aciton: 'comment'
    )
    #自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
    
  end

  acts_as_taggable
  
end
