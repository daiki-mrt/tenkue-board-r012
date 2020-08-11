class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.save ? (redirect_to post_path(@comment.post_id)):(redirect_to post_path(@comment.post_id), alert: 'コメントを入力してください。')
  end

  private
  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(
      :text,
      :user_id,
      :post_id,
    )
  end
end
