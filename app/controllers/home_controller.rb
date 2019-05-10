class HomeController < ApplicationController
  def index
	if !is_user_logged_in?
		redirect_to login_path
	end
  end
  
  def login
    if is_user_logged_in?
		redirect_to root_path
	end
  end
  
  def register
	if is_user_logged_in?
		redirect_to root_path
	end
  end
end
