class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc)
  end

  def index
    @users = User.all
  end

  def leave
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
