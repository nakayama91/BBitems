class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc)
    @genres = Genre.all
  end

  def index
    @users = User.all
    @genres = Genre.all
  end

  def leave
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
