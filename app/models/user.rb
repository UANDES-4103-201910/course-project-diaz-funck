class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  attr_accessor :current_password
  belongs_to :role
  belongs_to :location, :optional => true
  belongs_to :geofence, optional: true
  has_one :user_profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :post_follows, dependent: :destroy
  has_many :post_shares, dependent: :destroy
  has_many :post_reports, dependent: :destroy
  has_many :votes, dependent: :destroy
  before_validation :set_default_role
  validates :username, :email, presence: true
  validates :username, uniqueness: true
  validates :password, presence: true, if: :should_validate?
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :password, length: { minimum: 6 }, if: :should_validate?
  validates :terms_of_service, acceptance: true

  def self.from_omniauth(access_token)
    data = access_token.info

    where(email: data['email']).first_or_create do |user|
      user.username = data['name']
      user.email = data['email']
      user.password = Devise.friendly_token(length = 20)
    end
  end

  def is_admin?
    return self.role_id == 2
  end

  def is_super_admin?
    return self.role_id == 3
  end

  private
  def set_default_role
    self.role ||= Role.first
  end

  def should_validate?
    new_record? || password.present?
  end
end
