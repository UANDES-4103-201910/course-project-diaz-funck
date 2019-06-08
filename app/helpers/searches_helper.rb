module SearchesHelper

  def user_location(user)
    location = Location.find_by id: user.location_id
    return location.region+" "+location.country
  end

end
