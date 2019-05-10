class SearchesController < ApplicationController

  def index
    @collection = Post.all
  end

  def posts
    @collection = Post.all
  end

  def users
    @collection = User.all
  end

  def by_username
  end

  def by_country
  end

  def by_city
  end

  def by_title
  end

  def by_description
  end

  def by_author
  end
end
