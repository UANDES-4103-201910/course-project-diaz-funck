class AdminToolsController < ApplicationController
  def user_tools
    if !is_user_admin?
      redirect_to root_path
    else
      @users = User.all
    end
  end
  
  def dumpster
    if !is_user_admin?
      redirect_to root_path
    else
      @dumpster_records = get_dumpstered_post_records
    end
  end
  
  private
    def get_dumpstered_post_records
      return DumpsteredPost.all
    end
end
