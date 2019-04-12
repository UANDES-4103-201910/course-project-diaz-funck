class Post < ApplicationRecord
  belongs_to :user
  belongs_to :location, optional: true
  has_many :post_follows, dependent: :destroy
  has_many :post_shares, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :post_attachments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates :title, :description, presence: true
end
