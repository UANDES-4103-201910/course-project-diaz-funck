class HomeController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to guest_index_path
    else
      @posts = get_all_posts
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
end
