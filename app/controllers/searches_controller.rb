class SearchesController < ApplicationController

  def index
    if !params[:q]
      @posts = nil
    else
      @posts = Post.where('title LIKE ?', '%'+params[:q]+'%').all
    end
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
