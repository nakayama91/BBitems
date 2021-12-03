class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def leave
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
