class UserProfile < ApplicationRecord
  validates :biography, length: { maximum: 500 }
  has_one_attached :image
end
