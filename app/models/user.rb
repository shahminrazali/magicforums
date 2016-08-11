class User < ApplicationRecord
  has_many :topics
  has_many :posts
  has_many :comments

  has_secure_password
  mount_uploader :image, ImageUploader

  enum role: [:user, :moderator, :admin]
end
