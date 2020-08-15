class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @posts = Post.including.desc.page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.save ? (redirect_to root_path):(render :new)
  end

  def show
    if flash[:comment_id].present?
      @comment = Comment.find_by(id: flash[:comment_id])
    else
      @comment = Comment.new
    end
    @comments = Comment.including.where(post_id: @post.id).desc
  end

  def edit
  end

  def update
    @post.update(post_params) ? (redirect_to post_path(@post.id)):(render :edit)
  end

  def destroy
    @post.destroy ? (redirect_to root_path):(redirect_to post_path(@post.id))
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(
      :text,
      :user_id,
    )
  end
end
