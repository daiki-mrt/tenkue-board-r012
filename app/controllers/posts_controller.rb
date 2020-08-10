class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save ? (redirect_to root_path):(render :new)
  end

  private
  def post_params
    params.require(:post).permit(
      :text,
      :user_id,
    )
  end
end
