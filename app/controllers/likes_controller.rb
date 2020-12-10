class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:destroy]
  before_action -> { access_limit(@like) }, only: [:destroy]

  def create
    @like = current_user.likes.build(like_param)
    @like.save

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @like.destroy

    redirect_back(fallback_location: root_path)
  end

  private
  def like_param
    params.permit(:post_id)
  end

  def set_like
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
  end
end
