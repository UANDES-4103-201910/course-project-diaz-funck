class SearchesController < ApplicationController

  def index
    @collection = get_all_posts
  end

  def posts
    @collection = get_all_posts
  end

  def users
    @collection = User.all
  end

  def by_username
    @collection = User.all
  end

  def by_country
    @collection = User.all
  end

  def by_city
    @collection = User.all
  end

  def by_title
    @collection = get_all_posts
  end

  def by_description
    @collection = get_all_posts
  end

  def by_author
    @collection = get_all_posts
  end

  def user_location(user)
    location = Location.find_by id: user.location_id
    return location.region+" "+location.country
  end
  helper_method :user_location

end
