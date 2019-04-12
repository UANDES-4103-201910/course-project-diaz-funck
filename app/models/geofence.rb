class Geofence < ApplicationRecord
  has_many :geofences_locations
  validates :name, presence: true
end
