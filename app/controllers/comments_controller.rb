class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if not @comment.save
      @comment.errors.full_messages.each do |message|
        flash[:alert] = message
      end
    end
    redirect_to post_path(params[:post_id])
  end

  private

    def comment_params
      params.require(:comment).permit(:comment,:post_id).merge(user_id: current_user.id)
    end
end
