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
    return true
  end

  def is_user_admin?
    return true
  end
end
