class Post < ApplicationRecord
  validates :content, presence: true, length: {maximum: 2000}

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
end
