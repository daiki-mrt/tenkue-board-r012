class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :access_limit, only: [:edit, :update, :destroy]

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

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
    @comments = Comment.all.where(post_id: params[:id])
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    @post.destroy!
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:content).merge(user_id: current_user.id)
  end

  def access_limit
    @post = Post.find(params[:id])

    if current_user.id != @post.user_id
      redirect_to root_path
    end
  end
end
