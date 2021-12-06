class ItemsController < ApplicationController

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
    @items = Item.all.order(created_at: :desc)
    @genres = Genre.all
    if params[:genre_id].present?
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.order(created_at: :desc)
    end
  end

  def show
    @item = Item.find(params[:id])
    @user = @item.user
    @genres = Genre.all
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
