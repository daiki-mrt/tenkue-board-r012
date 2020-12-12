class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def access_limit(model)
    if current_user.id != model.user_id
        redirect_to root_path
    end
  end

  # 引数のコントローラー名に応じて値を取得する
  def set_model(controller_name)
    case controller_name
    when "posts" then
      @post = Post.find(params[:id])
    when "comments" then
      @comment = Comment.find(params[:id])
    when "likes" then
      #いいね解除ボタンを連打した時、2回目以降は値が取得できないため直前のページに戻す。
      if not @like = Like.find_by(id: params[:id])
        redirect_back(fallback_location: root_path)
      end
    end
  end
end
