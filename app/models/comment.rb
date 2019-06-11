class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :responses, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
  belongs_to :parent_comment, class_name: "Comment", optional: true
  validates :content, presence: true
  validates :content, length: { maximum: 500 }

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
