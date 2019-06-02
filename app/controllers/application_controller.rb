class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :render_navbar

  def render_navbar
    if is_user_admin?
      render :partial => "layouts/navbar_admin"
    elsif is_user_logged_in?
      render :partial => "layouts/navbar_user"
    else
      render :partial => "layouts/navbar_guest"
    end
  end

  def is_user_logged_in?
    return false
  end
  helper_method :is_user_logged_in?

  def is_user_admin?
    return false
  end

  def is_user_super_admin?
    return false
  end

  def get_all_posts
    return Post.all
  end
end
