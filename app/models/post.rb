class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  has_many_attached :images
  has_many :post_follows, dependent: :destroy
  has_many :post_shares, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :post_attachments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, presence: true

  def score
    votes = self.votes
    total_score = 0
    for vote in votes
      total_score += 1 if vote.up
      total_score -= 1 if !vote.up
    end
    return total_score
  end

  def upvoted_by_user(user_id)
    vote = Vote.where(user_id: user_id, post_id: self.id).first
    if vote == nil || !vote.up
      return false
    end
    return true
  end

  def downvoted_by_user(user_id)
    vote = Vote.where(user_id: user_id, post_id: self.id).first
    if vote == nil || vote.up
      return false
    end
    return true
  end

  def followed_by_user(user_id)
    follow = PostFollow.where(user_id: user_id, post_id: self.id).first
    if follow == nil
      return false
    end
    return true
  end

  def shared_by_user(user_id)
    share = PostShare.where(user_id: user_id, post_id: self.id).first
    if share == nil
      return false
    end
    return true
  end

 def can_edit?(user_id)
    user = User.find(user_id)
    if user == nil
      return false
    end
    if user.id == self.user.id
      return true
    end
    if user.is_admin?
      return true
    end
    return false
  end
end
