class CommentsController < ApplicationController
  def create
    @comment = Comment.new
    @comment.post_id = params[:post_id]
    @comment.content = params[:comment]
    @comment.save
    redirect_to "/"
  end

  def delete
    comment = Comment.find(params[:comment_id])
    comment.destroy
    redirect_to '/'
  end
end
