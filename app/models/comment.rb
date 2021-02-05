class Comment < ApplicationRecord

  belong_to :tweet
  belong_to :user

  validates :content, presence: true

end
