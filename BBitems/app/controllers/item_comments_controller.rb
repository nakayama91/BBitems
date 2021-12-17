class ItemCommentsController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    comment = current_user.item_comments.new(item_comment_params)
    comment.item_id = @item.id
    comment.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    item_comment = @item.item_comments.find(params[:id])
    item_comment.destroy
  end

  private

  def item_comment_params
    params.require(:item_comment).permit(:comment)
  end
end
