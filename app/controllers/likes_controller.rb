class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: [:destroy]
  before_action -> { access_limit(@like) }, only: [:destroy]

  def create
    @like = current_user.likes.build(params.permit(:post_id))

    #お気に入り作成ボタンを連打した時の対策
    if Like.exists?(user_id: @like.user_id, post_id: @like.post_id)
      redirect_back(fallback_location: root_path)
    else
      @like.save

      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @like.destroy

    redirect_back(fallback_location: root_path)
  end

  private
  def set_like
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
  end

  def access_limit(model)
    #お気に入りボタン解除ボタンを連打した時の対策
    if model == nil
      redirect_back(fallback_location: root_path)
    elsif current_user.id != model.user_id
      redirect_to root_path
    end
  end
end
