module SearchesHelper

  def user_location(user)
    location = Location.find_by id: user.location_id
    if location != nil
      return location.region+" "+location.country
    else
      return "None"
    end
  end

end
