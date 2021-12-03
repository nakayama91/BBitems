class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  def configure_permitted_parameters
    #新規登録時に、userへ追加したカラム情報の取得を許可
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    #会員情報編集時に、userへ追加したカラム情報の取得を許可
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :introduction, :image])
  end

end