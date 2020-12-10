class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action -> { access_limit(@post) }, only: [:edit, :update, :destroy]

  def index
    @posts = Post.eager_load(:user).all.order(created_at: "DESC")
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
    @comments = @post.comments.eager_load(:user).order(created_at: "DESC")
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

  def set_post
    @post = Post.find(params[:id])
  end
end
