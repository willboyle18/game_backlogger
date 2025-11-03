class CommentsController < ApplicationController
  before_action :require_authentication

  def create
    commentable = find_commentable
    @comment = commentable.comments.new(comment_params)
    @comment.commentable = commentable
    @comment.user = Current.user
    if @comment.save
      redirect_back fallback_location: root_path, notice: "Comment posted!"
    else
      redirect_back fallback_location: root_path
    end
  end


  private

  def find_commentable
    if params[:user_id]
      User.find(params[:user_id])
    elsif params[:review_id]
      Review.find(params[:review_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end