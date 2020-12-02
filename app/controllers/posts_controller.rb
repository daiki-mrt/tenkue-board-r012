class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @posts = Post.eager_load(:user).all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path
    else
      render :new
    end
  end

  private
  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end
end
