json.extract! user, :id, :role_id, :location_id, :geofence_id, :username, :email, :password, :created_at, :updated_at
json.url user_url(user, format: :json)
