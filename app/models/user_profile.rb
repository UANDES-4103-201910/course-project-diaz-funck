class UserProfile < ApplicationRecord
  validates :biography, length: { maximum: 500 }
end
