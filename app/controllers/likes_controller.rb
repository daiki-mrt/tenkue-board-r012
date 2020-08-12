class LikesController < ApplicationController
  before_action :set_post

  def create
    like = Like.create(user_id: current_user.id, post_id: @post.id)
    redirect_branch(request.referer)
  end

  def destroy
    like = Like.find_by(id: params[:id])
    like.destroy
    redirect_branch(request.referer)
  end

  private
  def set_post
    @post = Post.find_by(id: params[:post_id])
  end

  def redirect_branch(url)
    url.include?("posts") ? (redirect_to post_path(@post)):(redirect_to root_path)
  end
end
