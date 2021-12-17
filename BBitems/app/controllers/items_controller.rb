class ItemsController < ApplicationController
  before_action :authenticate_user!, except: %i[index genre_index]

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
    if @item.save(item_params)
      redirect_to items_path
    else
      render :new
    end
  end

  def index
    @genres = Genre.all # サイドバーにジャンルを表示
    @items_all = Item.all
    if selection = params[:keyword] # 並べ替え表示
      @items = Item.sort(selection)
      @items = Kaminari.paginate_array(@items).page(params[:page]).per(12)
    else
      @items = Item.all.page(params[:page]).per(12).reverse_order # 並べ替えしない状態は全投稿を表示
    end
  end

  def genre_index
    @genres = Genre.all # サイドバーにジャンルを表示
    @genre = Genre.find(params[:genre_id])
    @items = @genre.items.page(params[:page]).per(12).reverse_order
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
    @genres = Genre.all
    @item_comment = ItemComment.new
  end

  def edit
    @item = Item.find(params[:id])
    if @item.user == current_user
      render :edit
    else
      redirect_to items_path
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :introduction, :image, :maker, :user_id, :evaluation, :price)
  end
end
