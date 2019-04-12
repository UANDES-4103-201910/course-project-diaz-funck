class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location
  has_many :post_follows
  has_many :post_shares
  has_many :post_reports
  has_many :post_attachments
  has_many :votes
  has_many :comments
  validates :title, :description, presence: true
end
