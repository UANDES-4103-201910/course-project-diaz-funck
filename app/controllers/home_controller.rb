class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to guest_index_path
    else
      posts = []
      query = []
      if home_params[:commit] == "Hot"
        posts = Post.all.sort_by {|post| post.score }.reverse
      elsif home_params[:commit] == "Newest"
        posts = Post.all.sort_by {|post| post.created_at }.reverse
      elsif ["Country","Region"].include? home_params[:commit]
        if home_params[:last_view_filter] == "Newest"
          query = Post.all.sort_by {|post| post.created_at }.reverse
        else
          query = Post.all.sort_by {|post| post.score }.reverse
        end
        if home_params[:commit] == "Country"
          @location_selected = Location.first.country
          query.each do |post|
            if post.location != nil and post.location.country == @location_selected
              Rails.logger.debug(@location_selected)
              posts.push(post)
            end
          end
        else
          @location_selected = Location.first.id
          query.each do |post|
            if post.location != nil and post.location.id == @location_selected
              posts.push(post)
            end
          end
        end
      elsif home_params[:location] != nil and home_params[:commit] == nil
        @location_selected = home_params[:location]
        if home_params[:last_view_filter] == "Newest"
          query = Post.all.sort_by {|post| post.created_at }.reverse
        else
          query = Post.all.sort_by {|post| post.score }.reverse
        end
        if home_params[:commit] == "Country"
          query.each do |post|
            if post.location != nil and post.location.country == @location_selected
              Rails.logger.debug(@location_selected)
              posts.push(post)
            end
          end
        else
          query.each do |post|
            if post.location != nil and (home_params[:location].match(/^\d+$/) != nil and post.location.id == Integer(@location_selected))
              posts.push(post)
            end
          end
        end
      elsif [nil,"All"].include? home_params[:commit]
        if home_params[:last_view_filter] == "Newest"
          posts = Post.all.sort_by {|post| post.created_at }.reverse
        else
          posts = Post.all.sort_by {|post| post.score }.reverse
        end
      end
      @posts = posts
    end
  end

  def guest_index
    if user_signed_in?
      redirect_to root_path
    end
  end

  def login
    if user_signed_in?
      redirect_to root_path
    end
  end

  def register
    if user_signed_in?
      redirect_to root_path
    end
  end

  def legal

  end

  private
  def home_params
    params.permit(:utf8, :commit, :location, :last_view_filter)
  end

end
