class ProfilesController < ApplicationController

  def my_profile
    @posts = get_all_posts
  end

  def all_history
    @posts = get_all_posts
  end

  def created
    @posts = get_all_posts
  end

  def shared
    @posts = get_all_posts
  end

  def commented
    @posts = get_all_posts
  end

  def upvoted
    @posts = get_all_posts
  end

  def downvoted
    @posts = get_all_posts
  end

  def history_action
    return "Username commented a post"
  end
  helper_method :history_action
end
