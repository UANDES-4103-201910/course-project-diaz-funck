class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  helper_method :render_navbar, :is_user_admin?, :is_user_super_admin?

  def render_navbar
    if is_user_admin?
      render :partial => "layouts/navbar_admin"
    elsif user_signed_in?
      render :partial => "layouts/navbar_user"
    else
      render :partial => "layouts/navbar_guest"
    end
  end

  def is_user_admin?
    if current_user != nil
      return current_user.is_admin?
    end
    return false
  end

  def is_user_super_admin?
    if current_user != nil
      return current_user.is_super_admin?
    end
    return false
  end

  def get_all_posts
    return Post.all
  end
end
