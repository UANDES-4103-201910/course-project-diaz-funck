class User < ApplicationRecord
  belongs_to :role
  belongs_to :location
  belongs_to :geofence
end
