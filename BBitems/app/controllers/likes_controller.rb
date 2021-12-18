class LikesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    like = @item.likes.new(user_id: current_user.id)
    like.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    like = @item.likes.find_by(user_id: current_user.id)
    like.destroy
  end
end
