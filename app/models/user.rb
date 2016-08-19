class User < ApplicationRecord
  has_many :topics
  has_many :posts
  has_many :comments
  has_many :votes

  has_secure_password
  mount_uploader :image, ImageUploader

  enum role: [:user, :moderator, :admin]

  def all_votes
    votes.all
  end
end
