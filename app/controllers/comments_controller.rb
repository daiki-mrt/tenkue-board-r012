class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :set_post, only: [:new, :edit, :update, :destroy]

  def new
    redirect_to post_path(@post.id)
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.save ? (redirect_to post_path(@comment.post_id)):(redirect_to post_path(@comment.post_id), alert: 'コメントを(140文字以内で)入力してください。')
  end

  def edit
    redirect_to post_path(@post.id), flash: {comment_id: @comment.id }
  end

  def update
    @comment.update(comment_params) ? (redirect_to post_path(@post.id)):(render :edit)
  end

  def destroy
    @comment.destroy ? (redirect_to post_path(@post.id)):(redirect_to post_path(@post.id), alert: '削除に失敗しました。')
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
