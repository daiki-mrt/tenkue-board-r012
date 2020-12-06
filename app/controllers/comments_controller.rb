class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.save
    redirect_to root_path
  end

  private

    def comment_params
      params.require(:comment).permit(:comment,:post_id).merge(user_id: current_user.id)
    end
end
