class UserProfile < ApplicationRecord
  validates :biography, length: { maximum: 500 }
  belongs_to :user
  has_one_attached :image
  before_create :set_default_image

  def can_edit?(user_id)
    user = User.find(user_id)
    if user == nil
      return false
    end
    if user.id == self.user.id
      return true
    end
    if user.is_admin?
      return true
    end
    return false
  end

  private
    def set_default_image
      self.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'placeholder-icon.png')), filename: 'default-image.png', content_type: 'image/png')
    end
end
