class Location < ApplicationRecord
  has_many :geofences_locations
  validates :country, :region, presence: true
end
