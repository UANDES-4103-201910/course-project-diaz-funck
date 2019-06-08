class ProfilesController < ApplicationController

  def show
    @user = User.find_by('id == ?',profile_params[:id])
    case params[:history]
    when 'created'
      @history_elements = created_posts(@user)
    when 'shared'
      @history_elements = shared_posts(@user)
    when 'commented'
      @history_elements = commented_posts(@user)
    when 'upvoted'
      @history_elements = voted_posts(@user,true)
    when 'downvoted'
      @history_elements = voted_posts(@user,false)
    else
      @history_elements = created_posts(@user) | shared_posts(@user) | commented_posts(@user) | voted_posts(@user,true) | voted_posts(@user, false)
    end
  end

  def update
    @user = User.find_by('id == ?',profile_params[:id])
    @user.username = profile_params[:username]
    @user.user_profile[:biography] = profile_params[:biography]
    @user.location = Location.find_by('id == ?',profile_params[:location_id])
    if @user.save
      flash[:notice] = "Success"
    else
      flash[:alert] = "Error"
    end
    redirect_to profile_path(@user.id)
  end

  private

    def profile_params
      params.permit(:id, :history, :username, :biography, :location_id)
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
