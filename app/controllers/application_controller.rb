class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters,if: :devise_controller? 
  #デバイス機能実行前にconfigure_permitted_parametersの実行をする。

  protected

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admins_categories_path
    when User
      topics_path
    end
  end

  def after_sign_out_path_for(resource)
    new_user_session_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email])

    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction])
  end

end
