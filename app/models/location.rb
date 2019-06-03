class Location < ApplicationRecord
  has_many :geofences_locations
  validates :country, :region, presence: true

  def region_country
    self.region + ', ' + self.country
  end

  def country_region
    self.country + ', ' + self.region
  end
end
