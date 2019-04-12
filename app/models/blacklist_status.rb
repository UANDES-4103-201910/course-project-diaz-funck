class BlacklistStatus < ApplicationRecord
  has_many :blacklisted_users
  validates :name, presence: true
end
