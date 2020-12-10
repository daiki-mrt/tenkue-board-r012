class LikesController < ApplicationController
  before_action :authenticate_user!
  def create
    @like = current_user.likes.build(like_param)
    @like.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy

    redirect_back(fallback_location: root_path)
  end

  private
  def like_param
    params.permit(:post_id)
  end
end
