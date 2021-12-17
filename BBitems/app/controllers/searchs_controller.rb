class SearchsController < ApplicationController
  def index # 部分検索、nameカラムとmakerカラムが検索可能
    @items = Item.where('name LIKE ?', '%' + params[:search] + '%')
                 .or(Item.where('maker LIKE ?', '%' + params[:search] + '%'))
                 .order(created_at: :desc) # 製品名にて検索可能
    @items = Kaminari.paginate_array(@items).page(params[:page]).per(12)
    @genres = Genre.all # サイドバーにジャンルを表示
    # 検索結果の該当件数を格納
    @items_count = Item.where('name LIKE ?', '%' + params[:search] + '%')
                       .or(Item.where('maker LIKE ?', '%' + params[:search] + '%')).count
  end
end
