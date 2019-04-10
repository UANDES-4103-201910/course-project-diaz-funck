class BlacklistStatus < ApplicationRecord
  has_many :blacklisted_users
end
