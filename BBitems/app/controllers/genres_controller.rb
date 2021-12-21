class GenresController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_admin

  def index
    @genre = Genre.new
    @genres = Genre.all
  end

  def show
    @genre = Genre.find(params[:id])
  end

  def create
    @genre = Genre.new(genre_params)
    @genres = Genre.all
    if @genre.save
      flash[:notice] = "新規ジャンルを登録しました"
      redirect_to genres_path
    else
      flash[:alert] = "登録内容に誤りが有ります"
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      flash[:notice] = "ジャンルの編集が完了しました"
      redirect_to genres_path
    else
      flash[:alert] = "編集内容に誤りが有ります"
      render :edit
    end
  end

  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def ensure_correct_admin
    redirect_to root_path unless current_user.admin?
  end
end
