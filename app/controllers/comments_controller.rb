class CommentsController < ApplicationController
  #before_action :set_comment, only: [:edit, :update, :destroy]
  
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "Succes"
    else
      flash[:alert] = "Error"
    end
    redirect_to post_path(@comment.post_id)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :post_id, :parent_comment_id, :content)
    end
end
