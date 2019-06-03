class ProfilesController < ApplicationController

  def show
    Rails.logger.debug(profile_params)
    @user = User.find_by('id == ?',profile_params[:id])
    @history_elements = created_posts(@user) | shared_posts(@user) | commented_posts(@user) | voted_posts(@user,true) | voted_posts(@user, false)
  end

  def show_created
    @history_elements = created_posts(@user)
  end

  private

    def profile_params
      params.permit(:id, :history)
    end

    def commented_posts(user)
      elements = []
      Comment.where('user_id == ?', user.id).each do |comment|
        elements.push([Post.find_by('id == ?', comment.post_id), @user.username+" commented a post"])
      end
      return elements
    end

    def created_posts(user)
      elements = []
      Post.where('user_id == ?', user.id).each do |created|
        elements.push([created,@user.username+" created a post"])
      end
      return elements
    end

    def shared_posts(user)
      elements = []
      PostShare.where('user_id == ?', user.id).each do |share|
        elements.push([Post.find_by('id == ?', share.post_id),@user.username+" shared a post"])
      end
      return elements
    end

    def followed_posts(user)
      elements = []
      PostFollow.where('user_id == ?', user.id).each do |follow|
        elements.push([Post.find_by('id == ?', follow.post_id),@user.username+" followed a post"])
      end
      return elements
    end

    def voted_posts(user, up)
      elements = []
      Vote.where('user_id == ? and up == ?', user.id, up).each do |vote|
        if up
          elements.push([Post.find_by('id == ?', vote.post_id),@user.username+" upvoted a post"])
        else
          elements.push([Post.find_by('id == ?', vote.post_id),@user.username+" downvoted a post"])
        end
      end
      return elements
    end

end
