class CommentsController < ApplicationController
  before_action :access_limit, only: [:edit, :update, :destroy]
  
  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      redirect_to post_path(params[:post_id])
    else
      respond_alert
    end
  end

  def edit
    # posts#showへ
    @post = Post.find(params[:post_id])
    @comments = @post.comments.eager_load(:user).order(created_at: "DESC")
    render "posts/show"
  end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(params[:post_id])
    else
      respond_alert
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(params[:post_id])
  end

  private

    def comment_params
      params.require(:comment).permit(:comment,:post_id).merge(user_id: current_user.id)
    end

    def access_limit
      @comment = Comment.find(params[:id])

      if current_user.id != @comment.user_id
        redirect_to post_path(params[:post_id])
      end
    end

    def respond_alert
      respond_to do |format|
        format.js {  @comment.errors.full_messages.each do |message|
          flash.now[:alert] = message
        end }
      end
    end
end
