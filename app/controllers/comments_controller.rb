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

  def edit
    @comment = Comment.find(params[:id])
    # posts#showへ
    @post = Post.find(params[:post_id])
    @comments = @post.comments.eager_load(:user)
    render "posts/show"
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

    # def comment_params
    #   params.require(:comment).permit(:comment,:post_id).merge(user_id: current_user.id)
    # end

    def comment_params
      params.require(:comment).permit(:comment).merge(user_id: current_user.id, post_id: params[:post_id])
    end
end
