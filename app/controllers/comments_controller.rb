class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      respond_to do |format|
        format.js {  @comment.errors.full_messages.each do |message|
          flash.now[:alert] = message
        end }
      end
    end
  end

  private

    def comment_params
      params.require(:comment).permit(:comment,:post_id).merge(user_id: current_user.id)
    end
end
