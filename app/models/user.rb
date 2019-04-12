class User < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :geofence, optional: true
  has_one :user_profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_follows, dependent: :destroy
  has_many :post_shares, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :username, :email, :password, presence: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }
end
