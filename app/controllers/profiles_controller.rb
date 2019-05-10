class ProfilesController < ApplicationController

  def index
    @history = Post.all
  end

  def all_history
    @history = Post.all
  end

  def created
  end

  def shared
  end

  def commented
  end

  def upvoted
  end

  def downvoted
  end
end
