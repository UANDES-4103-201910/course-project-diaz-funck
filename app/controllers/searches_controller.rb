class SearchesController < ApplicationController

  def index
    @collection = {type: 'posts', content: []}
    if search_params[:last_search] != nil
      search_params[:q] = search_params[:last_search]
    end
    case search_params[:commit]
    when "Users"
      @collection[:type] = 'users'
      @collection[:content] = User.where('username LIKE ?', '%'+search_params[:q]+'%').all
    when "Username"
      @collection[:type] = 'users'
      @collection[:content] = User.where('username LIKE ?', '%'+search_params[:q]+'%').all
    when "Country"
      @collection[:type] = 'users'
      locations = Location.where('country LIKE ?', '%'+search_params[:q]+'%').all
      User.all.each do |user|
        if locations.include? user.location then @collection[:content].push(user) end
      end
    when "Region"
      @collection[:type] = 'users'
      locations = Location.where('region LIKE ?', '%'+search_params[:q]+'%').all
      User.all.each do |user|
        if locations.include? user.location then @collection[:content].push(user) end
      end
    when "Description"
      @collection[:content] = Post.where('description LIKE ?', '%'+search_params[:q]+'%').all
    when "Author"
      users = User.where('username LIKE ?', '%'+search_params[:q]+'%').all
      Post.all.each do |post|
        if users.include? post.user then @collection[:content].push(post) end
      end
    else
      @collection[:content] = Post.where('title LIKE ?', '%'+search_params[:q]+'%').all
    end
  end

  private
  def search_params
    params.permit(:q, :commit, :last_search)
  end

end
