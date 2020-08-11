class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :set_host

  protected
  def set_host
    Rails.application.routes.default_url_options[:host] = request.host_with_port
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def check_guest
    email = resource&.email || params[:user][:email].downcase
    if email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーの変更・削除はできません。'
    end
  end
end
