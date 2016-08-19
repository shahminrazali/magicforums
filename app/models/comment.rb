class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  has_many :votes

  mount_uploader :image, ImageUploader

  def total_votes
    votes.pluck(:value).sum
  end

  def count_votes
    votes.pluck(:comment_id).count
  end
  
  def total_upvotes
    votes.where(value: 1).count
  end

  def total_downvotes
    votes.where(value: -1).count
  end

end
