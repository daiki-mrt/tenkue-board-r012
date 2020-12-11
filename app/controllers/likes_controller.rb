class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action -> { set_model(controller_name) }, only: [:destroy]
  before_action -> { access_limit(@like) }, only: [:destroy]

  def create
    @like = current_user.likes.build(params.permit(:post_id))

    #お気に入り作成ボタンを連打した時の対策
    if Like.exist_or_not?(@like)
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
end
