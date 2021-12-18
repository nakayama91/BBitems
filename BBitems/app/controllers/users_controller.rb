class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @items = @user.items.order(created_at: :desc)
    @genres = Genre.all
  end

  def index
    @users = User.all
    @genres = Genre.all
  end

  def leave; end

  def followings
    user = User.find(params[:id])
    @users = user.followings
    @genres = Genre.all
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
    @genres = Genre.all
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :image)
  end
end
