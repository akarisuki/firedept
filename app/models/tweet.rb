class Tweet < ApplicationRecord
  #1500文字制限
  validates :text, presence: ture, length: { maximum: 1500 }
  validates :title, presence: ture, length: { maximum: 40 }

  #users
  belongs_to :user


  # タグ機能
  acts_as_taggble
end
