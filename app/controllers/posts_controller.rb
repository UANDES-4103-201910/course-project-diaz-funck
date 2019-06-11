class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote, :follow, :share, :report, :delete_comment]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @comments = @post.comments
    @comment = Comment.new
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post_owner = current_user.id
  end

  # GET /posts/1/edit
  def edit
    if current_user == nil || !@post.can_edit?(current_user.id) || !post_accessible?
      redirect_to root_path
    end
    @post_owner = @post.user.id
  end

  # POST /posts
  # POST /posts.json
  def create
    create_params = post_params.except(:comment_id, :comments_disabled)
    @post = Post.new(create_params)
    @post.open = !post_params[:comments_disabled]

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    if current_user != nil && @post.can_edit?(current_user.id) && post_accessible?
      respond_to do |format|
        update_params = post_params.except(:comment_id, :comments_disabled)
        update_params[:open] = !post_params[:comments_disabled]
        if @post.update(update_params)
          format.html { redirect_to @post, notice: 'Post was successfully updated.' }
          format.json { render :show, status: :ok, location: @post }
        else
          format.html { render :edit }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def new_comment
    @comment = Comment.new
  end

  def upvote
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      if !post_accessible?
        redirect_to root_path
      end
      vote = Vote.where(post_id: @post.id, user_id: current_user.id).first_or_create
      respond_to do |format|
        if vote.update(up: true)
          format.html { redirect_to @post, notice: 'Post was successfully upvoted.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { redirect_to @post }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end  
      end
    end
  end

  def downvote
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      if !post_accessible?
        redirect_to root_path
      end
      vote = Vote.where(post_id: @post.id, user_id: current_user.id).first_or_create
      respond_to do |format|
        if vote.update(up: false)
          format.html { redirect_to @post, notice: 'Post was successfully downvoted.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { redirect_to @post }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end  
  end

  def follow
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      if !post_accessible?
        redirect_to root_path
      end
      new_follow = PostFollow.where(post_id: @post.id, user_id: current_user.id).first
      respond_to do |format|
        if new_follow == nil
          PostFollow.create(post_id: @post.id, user_id: current_user.id)
          format.html { redirect_to @post, notice: 'Post followed successfully.' }
          format.json { render :show, status: :created, location: @post }
        else
          new_follow.destroy
          format.html { redirect_to @post, notice: 'Post unfollowed.' }
        end
      end
    end  
  end

  def share
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      if !post_accessible?
        redirect_to root_path
      end
      new_share = PostShare.where(post_id: @post.id, user_id: current_user.id).first
      respond_to do |format|
        if new_share == nil
          PostShare.create(post_id: @post.id, user_id: current_user.id)
          format.html { redirect_to @post, notice: 'Post shared successfully.' }
          format.json { render :show, status: :created, location: @post }
        else
          new_share.destroy
          format.html { redirect_to @post, notice: 'Post unshared.' }
        end
      end
    end  
  end

  def report
    if !user_signed_in?
      redirect_to new_user_session_path
    else
      if !post_accessible?
        redirect_to root_path
      end
      new_report = PostReport.where(post_id: @post.id, user_id: current_user.id).first
      respond_to do |format|
        if new_report == nil
          PostReport.create(post_id: @post.id, user_id: current_user.id)
          format.html { redirect_to @post, notice: 'Post reported successfully.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { redirect_to @post }
        end
      end
    end  
  end

  def delete_comment
    comment = Comment.find(params[:comment_id])
    respond_to do |format|
      if current_user != nil && comment.can_edit?(current_user.id)
        comment.destroy
        format.html { redirect_to @post, notice: 'Comment deleted successfully.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { redirect_to root_path }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def post_accessible
      !@post.dumpstered? || is_user_admin?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :location_id, :title, :description, :gps_coordinate, :resolved, :comments_disabled, :comment_id, images: [])
    end
end
