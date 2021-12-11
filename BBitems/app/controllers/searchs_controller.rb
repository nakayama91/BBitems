class SearchsController < ApplicationController

  def index #部分検索
    @items = Item.where("name LIKE ? ", '%' + params[:search] + '%').order(created_at: :desc) #製品名にて検索可能
    @items = Item.where("maker LIKE ? ", '%' + params[:search] + '%').order(created_at: :desc) #メーカー名にて検索可能
    @genres = Genre.all
  end

end
