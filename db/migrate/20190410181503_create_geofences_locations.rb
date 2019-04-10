class CreateGeofencesLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :geofences_locations do |t|
      t.references :geofence, foreign_key: true
      t.references :location, foreign_key: true

      t.timestamps
    end
  end
end
