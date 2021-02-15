class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  validates :email, length: { maximum: 50 }
  mount_uploader :avatar, AvatarUploader
 

  has_many :tweets
  # , dependent: :destroy
  has_many :comments
  # , dependent: :destroy
  has_many :likes

  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :messages
  has_many :entries
  has_many :rooms, through: :entries
  
  has_many :following_relationships, foreign_key: "follower_id", class_name: "Relationships"
  has_many :following, through: :following_relationships
  has_many :following_relationships, foreign_key: "following_id", class_name: "Relationships"
  has_many :followiers, through: :following_relationships

  #フォローしているかを確認するメソッド
  def following?(user)
    following_relationships.find_by(following_id: user.id)
  end

  #フォローするときのメソッド
  def follow(user)
    following_relationships.create!(following_id: user.id)
  end

  #フォローを外すときのメソッド
  def unfollow(user)
    following_relationships.find_by(follower_id: user.id).destroy
  end

  #notifications
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id'
  has_many :passive_notifications, class_name: 'Notification',foreign_key: 'visited_id'

  def create_notification_follow!(current_user)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_user.id,id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
    
  
    



  

end
