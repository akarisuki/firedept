class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets
  # , dependent: :destroy
  has_many :comments
  # , dependent: :destroy
  has_many :likes

  has_many :liked_tweets, through: :likes, source: :tweets
  
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
    



  validates :username, presence: true, uniqueness: true

end
