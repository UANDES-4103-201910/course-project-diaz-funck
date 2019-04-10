class User < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :geofence
  has_one :user_profile
  has_many :post_follows
  has_many :post_shares
  has_many :post_reports
  has_many :post_attachments
  has_many :votes
  has_many :comments
end
