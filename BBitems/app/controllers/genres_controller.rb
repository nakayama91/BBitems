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
      redirect_to genres_path
    else
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    @genre = Genre.find(params[:id])
    if @genre.update(genre_params)
      redirect_to genres_path
    else
      render :edit
    end
  end


  private

  def genre_params
    params.require(:genre).permit(:name)
  end

  def ensure_correct_admin
    unless current_user.admin?
      redirect_to root_path
    end
  end

end
