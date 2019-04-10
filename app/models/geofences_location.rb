class GeofencesLocation < ApplicationRecord
  belongs_to :geofence
  belongs_to :location
end
