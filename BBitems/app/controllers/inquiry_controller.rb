class InquiryController < ApplicationController

  def index
    # 入力画面を表示
    @inquiry = Inquiry.new
  end

  def confirm
    # 入力内容の確認
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    if @inquiry.invalid?
      # 入力内容がNGなら入力画面を再表示
      render :index
    end
  end

  def thanks
    # メール送信
    @inquiry = Inquiry.new(params[:inquiry].permit(:name, :email, :message))
    InquiryMailer.received_email(@inquiry).deliver
    # 完了画面を表示
    render :thanks
  end

end
