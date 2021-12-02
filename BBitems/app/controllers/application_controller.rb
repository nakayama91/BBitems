class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    #新規登録時に、userへ追加したカラム情報の取得を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #カスタマー情報編集時に、userへ追加したカラム情報の取得を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :image_id])
  end

  #ログイン後の遷移先
  def after_sign_in_path_for(resource)
    current_user
  end

  #新規登録後の遷移先
  def after_sign_up_path_for(_resource)
    current_user
  end

  #ユーザー情報変更後の遷移先
  def after_update_path_for(resource)
    current_user
  end


end
