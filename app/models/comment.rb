class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :responses, class_name: "Comment", foreign_key: "parent_comment_id", dependent: :destroy
  belongs_to :parent_comment, class_name: "Comment", optional: true
  validates :content, presence: true
  validates :content, length: { maximum: 500 }
end