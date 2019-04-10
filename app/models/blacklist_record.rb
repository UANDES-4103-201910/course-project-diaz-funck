class BlacklistRecord < ApplicationRecord
  belongs_to :user
  belongs_to :blacklist_status
end
