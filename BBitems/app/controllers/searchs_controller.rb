class SearchsController < ApplicationController

  def index #部分検索
    @items = Item.where("name LIKE ? ", '%' + params[:search] + '%').order(created_at: :desc)
    @genres = Genre.all
  end

end
